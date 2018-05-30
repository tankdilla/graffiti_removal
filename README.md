# README

Graffiti removal reporting web service.

## Install

```
bundle install
```
to install required gems.

## Usage

```
rails s
```
to start server.

The service will run locally on port 3000.

Using a web browser, command line tool such as curl, or other application such as Postman, run queries agains the web service.

For example,

```
http://localhost:3000?last_name=Burke&year=2018&month=5
```

The required parameters are: last_name, year, and month.

Optional parameters are: graffiti_surface, graffiti_location.

Compare requests for multiple months by passing months separated by comma
```
http://localhost:3000?last_name=Burke&year=2018&month=4,5
```

Compare requests for multiple wards by passing last name separated by comma
```
http://localhost:3000?last_name=Burke,Harris&year=2018&month=5
```
