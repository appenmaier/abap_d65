@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Department'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity Z00_R_Department
  as select from /lrn/depment_rel
  association [0..*] to Z00_R_Employee as _Employees on $projection.Id = _Employees.DepartmentId
  association [0..1] to Z00_R_Employee as _Head      on $projection.HeadId = _Head.EmployeeId
  association [0..1] to Z00_R_Employee as _Assistant on $projection.AssistantId = _Assistant.EmployeeId
{
  key id                    as Id,
      description           as Description,
      head_id               as HeadId,
      assistant_id          as AssistantId,
      created_by            as CreatedBy,
      created_at            as CreatedAt,
      local_last_changed_by as LocalLastChangedBy,
      local_last_changed_at as LocalLastChangedAt,
      last_changed_at       as LastChangedAt,

      /* Assocaiations */
      _Employees,
      _Head,
      _Assistant
}
