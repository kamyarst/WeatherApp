# BDD Specs

## Story 1: Customer search for cities

### Narrative

```
As an online customer
I want the app to search for a given city name
So I can check the weather of the city
```

#### Scenarios (Acceptance criteria)

```
Given the customer has connectivity
 When the customer requests to see potential city names
 Then the app should display a list of cities from remote
```

### Narrative

```
As an offline customer
I want the app to show a popup that I don't have connectivity
So I can decide to connect to a network or not
```

#### Scenarios (Acceptance criteria)

```
Given the customer doesn't have connectivity
 When the customer requests to search for a city
 Then the app should display an error message
```

## Story 2: Customer requests too see live weather of a city

### Narrative

```
As an online customer
I want the app to show me weather data of my current location
So I can check the weather of my city
```

#### Scenarios (Acceptance criteria)

```
Given the customer has connectivity
  And the customer has enabled location service
 When the customer requests to see potential weather of a city
 Then the app should display a page containing weather data
  And replace the cache with the new weather
```

### Narrative

```
As an offline customer
I want the app to show the latest saved version of my the city weather
So I can check the weather when I am offline
```

#### Scenarios (Acceptance criteria)

```
Given the customer doesn't have connectivity
  And there’s a cached version of the weather
  And the cache is less than one day old
 When the customer requests to see the weather
 Then the app should display the latest saved weather 

Given the customer doesn't have connectivity
  And there’s a cached version of the weather
  And the cache is one day old or more
 When the customer requests to see the weather
 Then the app should display an error message

Given the customer doesn't have connectivity
  And the cache is empty
 When the customer requests to see the weather
 Then the app should display an error message
```

