@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Flight with Connection and Airport'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity Z00_I_ConnWithFligthAndAirport
  as select from /dmo/connection as Connection
  association [0..*] to /dmo/flight  as _Flights          on  _Flights.carrier_id    = $projection.CarrierId
                                                          and _Flights.connection_id = $projection.ConnectionId
  association [1..1] to /dmo/airport as _DepartureAirport on  $projection.AirportFromId = _DepartureAirport.airport_id
  association [1..1] to /dmo/airport as _ArrivalAirport   on  $projection.AirportToId = _ArrivalAirport.airport_id
{
  key Connection.carrier_id      as CarrierId,
  key Connection.connection_id   as ConnectionId,
      Connection.airport_from_id as AirportFromId,
      Connection.airport_to_id   as AirportToId,
      Connection.departure_time  as DepartureTime,
      Connection.arrival_time    as ArrivalTime,
      Connection.distance        as Distance,
      Connection.distance_unit   as DistanceUnit,

      /* Associations */
      _Flights,
      _DepartureAirport,
      _ArrivalAirport
}
where
  Connection.carrier_id = 'LH'
