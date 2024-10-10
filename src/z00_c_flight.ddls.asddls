@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Flight'
@Metadata.ignorePropagatedAnnotations: false
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity Z00_C_Flight
  with parameters
    P_CarrierId : /dmo/carrier_id,
    @Environment.systemField: #SYSTEM_DATE
    P_Deadline  : abap.dats
  as select from Z00_R_Flight
{
  key CarrierId,
  key ConnectionId,
  key FlightDate,
      Price,
      CurrencyCode,
      PlaneTypeId,
      SeatsMax,
      SeatsOccupied
}
where
      CarrierId  = $parameters.P_CarrierId
  and FlightDate > $parameters.P_Deadline
