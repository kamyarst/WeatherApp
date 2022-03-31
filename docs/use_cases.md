# Use Cases

## Load Locations From Remote Use Case

#### Data:
- URL
- Location Model

#### Primary course (happy path):
1. Execute "Load Locations Data" command with above data.
2. System downloads data from the URL.
3. System validates downloaded data.
4. System creates locations from valid data.
5. System delivers locations.

#### Invalid data – error course (sad path):
1. System delivers invalid data error.

#### No connectivity – error course (sad path):
1. System delivers connectivity error.

---

## Load Weather From Remote Use Case

#### Data:
- URL
- Location Model

#### Primary course (happy path):
1. Execute "Load Weather Item" command with above data.
2. System downloads data from the URL.
3. System validates downloaded data.
4. System creates Weather from valid data.
5. System delivers Weather item.

#### Invalid data – error course (sad path):
1. System delivers invalid data error.

#### No connectivity – error course (sad path):
1. System delivers connectivity error.

---

## Cache Weather Use Case

#### Data:
- Location Model

#### Primary course:
1. Execute "Save Weather item" command with above data.
2. System deletes old cache data.
3. System encodes Weather item.
4. System tunestamps the new cache.
5. System saves new cache data.
6. System delivers success message.

#### Retrieval error course (sad path):
1. System delivers error.

#### Expired cache course (sad path): 
1. System delivers no Weather data.

#### Empty cache course (sad path): 
1. System delivers no Weather data.

---

## Load Weather From Cache Use Case

#### Data:
- Location Model

#### Primary course:
1. Execute "Load Weather" command with above data.
2. System retrieves Weather data from cache.
3. System validates cache is less than one day old.
4. System creates Weather from cached data.
5. System delivers Weather.

#### Retrieval error course (sad path):
1. System delivers error.

#### Expired cache course (sad path): 
1. System delivers no Weather data.

#### Empty cache course (sad path): 
1. System delivers no Weather data.

---
