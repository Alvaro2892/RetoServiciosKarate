Feature: Get Tests on restful-booker
  Background:
    * def urlBase = 'https://restful-booker.herokuapp.com'
    * def usersPath = '/booking/'
  Scenario: Get booking with id 1
    Given url  urlBase + usersPath + 1
    And header Accept = "application/json"
    When method Get
    Then status 200
    And print response



    Scenario: Creates a new booking in the API
      * def requestCreateBooking =

    """ {
    "firstname" : "Alvaro",
    "lastname" : "Angulo",
    "totalprice" : 111,
    "depositpaid" : true,
    "bookingdates" : {
        "checkin" : "2023-02-28",
        "checkout" : "2019-03-28"
    },
    "additionalneeds" : "Breakfast"
}"""
      Given url  urlBase + usersPath
      And header Content-Type = "application/json"
      And header Accept = "application/json"
      And request requestCreateBooking
      When method post
      Then status 200
      And print response


    Scenario: CreateToken and update booking

    * def CreateToken =

    """ {

    "username" : "admin",
    "password" : "password123"
}"""
    Given url  urlBase + '/auth'
    And header Content-Type = "application/json"
    And request CreateToken
    When method post
    Then status 200
    And print response

      * def GetToken = response.token
      * print "Tenemos el token mira :" + GetToken




    * def UpdateBooking =

    """ {
    "firstname" : "James",
    "lastname" : "Brown",
    "totalprice" : 111,
    "depositpaid" : true,
    "bookingdates" : {
        "checkin" : "2018-01-01",
        "checkout" : "2019-01-01"
    },
    "additionalneeds" : "Breakfast"
}"""
    Given url   urlBase + usersPath + 1
    And header Content-Type = "application/json"
    And header Accept = "application/json"
    And header Cookie = 'token=' + GetToken
    And request UpdateBooking
    When method put
    Then status 200
    And print response


  Scenario: CreateToken and update booking Bad request

    * def CreateToken =

    """ {

    "username" : "admin",
    "password" : "password123"
}"""
    Given url  urlBase + '/auth'
    And header Content-Type = "application/json"
    And request CreateToken
    When method post
    Then status 200
    And print response

    * def GetToken = response.token
    * print "Tenemos el token mira :" + GetToken




    * def UpdateBooking =

    """ {
    "firstname" : "James",
    "lastname" : "Brown",
    "totalprice" : 111,
    "depositpaid" : true,
    "bookingdates" : {
        "checkin" : "2018-01-01",
        "checkout" : "2019-01-01"
    },
    "additionalneeds" : "Breakfast"
}"""
    Given url   urlBase + usersPath + 1
    And header Content-Type = "application/json"
    And header Accept = "application/json"
    And header Cookie =  + GetToken
    And request UpdateBooking
    When method put
    Then status 403
    And print response