@AccessControl.authorizationCheck: #NOT_REQUIRED
@UI.headerInfo.typeName: 'Business Partner'
@UI.headerInfo.typeNamePlural: 'Business Partners'
@Search.searchable: true
@UI.lineItem: [{criticality: 'Type'}]
define root view entity ZCDX_C_BUSINESS_PARTNER
  as projection on ZCDX_BUSINESS_PARTNER
{



  @UI.facet: [{
    id: 'HeaderFacetBusinessPartner',
    purpose: #HEADER,
    type: #FIELDGROUP_REFERENCE,
    label: 'Business Partner Info',
    targetQualifier: 'BP',
    position: 10
   },
   {
   id: 'HeaderFacetAddress',
    purpose: #HEADER,
    type: #FIELDGROUP_REFERENCE,
    label: 'Address',
    targetQualifier: 'ADDRESS',
    position: 20
   }
   ]
 
  @Search.defaultSearchElement: true
  @UI.lineItem: [{ position: 10, importance: #HIGH }, {type: #FOR_ACTION, dataAction: 'generateDOX42', label: 'Generate Factsheet DOX42'}]
  @UI.selectionField: [{ position: 10 }]
  @UI.fieldGroup: [{ position: 10, qualifier: 'BP' }]
  
  key Partner,

  @UI.lineItem: [{ position: 30, importance: #HIGH }]
  @UI.selectionField: [{ position: 30 }]
  @UI.fieldGroup: [{ position: 30, qualifier: 'BP' }]
  FirstName,
  @UI.lineItem: [{ position: 40, importance: #HIGH }]
  @UI.selectionField: [{ position: 40 }]
  @UI.fieldGroup: [{ position: 40, qualifier: 'BP' }]
  LastName,
  
  @UI.lineItem: [{ position: 50, importance: #HIGH }]
  @UI.selectionField: [{ position: 50 }]
  @UI.fieldGroup: [{ position: 50, qualifier: 'ADDRESS' }]
  City,
  
  
  @UI.hidden: true
  Type


}
