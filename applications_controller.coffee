'use strict'

class ApplicationsController
  @$inject = ['$scope', '$state', '$http', 'ngDialog']

  constructor: ($scope, $state, $http, ngDialog) ->
    $scope.sorting = {}

    $scope.hasPets = (group) ->
      typeof group.pets is 'string' and group.pets.trim().length > 0

    $scope.hasSmokers = (group) ->
      _(group.applicants).some('smoker')

    $scope.ngClass = (klass, isEnabled = true) ->
      klassObj = {}
      klassObj[klass] = isEnabled
      klassObj

    $scope.pluralMonths = (monthCount) ->
      return '' unless typeof monthCount is 'number'
      "#{monthCount} #{pluralize('month', monthCount)}"

    $scope.toggleGroup = (group) ->
      group.expanded = not group.expanded

    $scope.expandIconClass = (group) ->
      $scope.ngClass(if group.expanded then 'less' else 'more')

    $scope.rentalAsPercentOfIncomeClass = (group) ->
      if 0 <= group.rental_percent_of_income <= 39
        $scope.ngClass 'green'
      else if 40 <= group.rental_percent_of_income <= 50
        $scope.ngClass 'orange'
      else
        $scope.ngClass 'red'

    $scope.selectApplicants = ->
      ngDialog.open {
        scope: $scope
        template: '_helpers/modals/request_deposit.html'
        className: 'ngdialog-theme-default large'
        showClose: false
      }

    $scope.fetchData = ->
      url = "/agent/listings/#{$state.params.listingId}/applications/"
      config = {
        params: {
          sort_by: $scope.sorting.column
          sort_order: $scope.sorting.order
        }
      }
      $http.get(url, config).success (data) ->
        $scope.groups = data

    $scope.$watch 'sorting', $scope.fetchData, true


angular.module('app').controller(
  'ApplicationsController', ApplicationsController
)
