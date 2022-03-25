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

## Load Weather Data From Cache Use Case

#### Data:
- Location Model

#### Primary course (happy path):
1. Execute "Load Weather Data" command with above data.
2. System downloads data from the URL.
3. System validates downloaded data.
4. System delivers data.

#### Cancel course:
1. System does not deliver Weather data nor error.

#### Invalid data – error course (sad path):
1. System delivers invalid data error.

#### No connectivity – error course (sad path):
1. System delivers connectivity error.

---
