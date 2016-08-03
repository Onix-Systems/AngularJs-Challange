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
  beforeEach inject(($rootScope, $httpBackend, $controller, ngDialog, UserFactory, OfficesService) ->
      httpMock = $httpBackend
      scope = $rootScope.$new()
      httpMock.when('GET', '/agent/listings/' + 2 + '/applications/').respond 200, foo: 'bar'

      createController = ->
        $controller 'ApplicationsController',
          $scope: scope
          $state: {}
          $http: $httpBackend
          ngDialog: ngDialog
  
      createAddUserController = ->
        $controller 'AddUserController',
          $scope: scope
          $state: {}
          $http: $httpBackend
          OfficesService: OfficesService
          UserFactory: UserFactory
  
      return
    )
  describe 'UserFactory', ->
    it 'save', -> 
      return
    return
    
  describe 'AddUserController', ->
    it 'can save?', ->
      controller = createAddUserController()
      expect(false).toBe(false);
      return
    return
    
  describe 'ApplicationsController', ->

    group = pets:'dog',
    applicants: [
      'smoker'
      'nonsmoking'
      'healthy'
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
#      expect(scope.hasSmokers group).toBe(true);
      group.applicants.shift()
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
      httpMock.expectGET('GET', '/agent/listings/' + 2 + '/applications/')
#      httpMock.flush();
      
#      test = scope.fetchData()
#      console.log(test)
      return
    return  
  return
  