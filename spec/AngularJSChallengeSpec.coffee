describe 'AngularJS Challenge', ->
  $controller = undefined
  beforeEach module('app')
  beforeEach module('ngDialog')
  beforeEach ->
    module ($provide) ->
      $provide.value 'OfficesService', {}
      return
    return
  scope = undefined
  httpMock = undefined
  createController = undefined
  createAddUserController = undefined
  factory = undefined
  beforeEach inject(($rootScope, $httpBackend, $http, $controller, ngDialog, UserFactory, OfficesService) ->
      httpMock = $httpBackend
      scope = $rootScope.$new()
      httpMock.when('GET', '/agent/listings/2/applications/').respond 200, foo: 'bar'
      httpMock.when('POST', '/agent').respond 200, {data: {name: 'Jon Doe'}}
      createController = ->
      $controller 'ApplicationsController',
        $scope: scope
        $state: {params: {listingId: 2}}
        $http: $http
        ngDialog: ngDialog
      createAddUserController = ->
        ctrl = $controller 'AddUserController',
          $scope: scope
          $state: {go:(string) -> }
          $http: $http
          OfficesService: OfficesService
          UserFactory: UserFactory
        spyOn(ctrl.$state, 'go')
        return ctrl
      return
    )

  describe 'UserFactory', ->
    beforeEach inject(($httpBackend, UserFactory) ->
      httpMock.whenRoute('PUT','/agent/:id').respond (method, url, data, headers, params) ->
        return [200, {data: {name: 'Jon Doe', id: Number(params.id)}}]
      factory = UserFactory
      return
    )
    it 'save and update', ->
      userFactory = new factory(id: 5);
      userFactory.save();
      httpMock.flush();
      expect(userFactory.name).toBe('Jon Doe');
      expect(userFactory.id).toBe(5);
      return
      
    it 'save and create', ->
      userFactory = new factory();
      userFactory.save();
      httpMock.flush();
      expect(userFactory.name).toBe('Jon Doe');
      expect(userFactory.id).toBe(undefined);
      return
    return

  describe 'AddUserController', ->
    it 'can save?', ->
      controller = createAddUserController()
      controller.save();
      httpMock.flush();
      expect(controller.$state.go).toHaveBeenCalledWith('app.main.users.list');
      return
    return
    
  describe 'ApplicationsController', ->

    group = pets:'dog',
    applicants: [
      {'smoker': true}
      {'nonsmoking': true}
      {'healthy': true}
    ],
    expanded: true,
    rental_percent_of_income: 25
    
    it 'has pets?', ->
      controller = createController()
      expect(scope.hasPets group).toBe(true);
      expect(scope.hasPets pets: '').toBe(false);
      return  
    
    it 'has smokers?', ->
      controller = createController()
      expect(scope.hasSmokers group).toBe(true);
      group.applicants[0].smoker = false
      expect(scope.hasSmokers group).toBe(false);
      return

    it 'ngClass should return class obj', ->
      controller = createController()
      expect(scope.ngClass 'popup').toEqual(popup: true)
      expect(scope.ngClass 'popup', true).toEqual(popup: true)
      expect(scope.ngClass 'popup', false).toEqual(popup: false)
      return

    it 'pluralMonths', ->
      controller = createController()
      expect(scope.pluralMonths 12).toEqual('12 months')
      expect(scope.pluralMonths '12').toEqual('')
      return

    it 'toggleGroup', ->
      controller = createController()
      expect(scope.toggleGroup group).toBe(false)
      group.expanded = false
      expect(scope.toggleGroup group).toBe(true)
      return

    it 'expandIconClass', ->
      controller = createController()
      group.expanded = true
      expect(scope.expandIconClass group).toEqual(less: true)
      group.expanded = false
      expect(scope.expandIconClass group).toEqual(more: true)
      return

    it 'rentalAsPercentOfIncomeClass', ->
      controller = createController()
      expect(scope.rentalAsPercentOfIncomeClass group).toEqual(green: true)
      group.rental_percent_of_income = 45
      expect(scope.rentalAsPercentOfIncomeClass group).toEqual(orange: true)
      group.rental_percent_of_income = 55
      expect(scope.rentalAsPercentOfIncomeClass group).toEqual(red: true)
      return

    it 'selectApplicants', ->
      controller = createController()
      dialog = scope.selectApplicants()
      expect(dialog.id).toEqual('ngdialog1')
      return

    it 'fetchData', ->
      controller = createController()
      scope.fetchData()
      httpMock.flush();
      expect(scope.groups).toEqual(foo: 'bar')
      return
    return  
  return
  