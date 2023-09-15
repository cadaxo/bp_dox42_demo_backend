@AccessControl.authorizationCheck: #NOT_REQUIRED



//@Search.searchable: true
@UI.lineItem: [ {criticality: 'CriticalityCode' } ]

@UI: {
    headerInfo: {
        typeName: 'Business Partner',
        typeNamePlural: 'Business Partners',
        title: {
            type: #STANDARD, value: 'FullName'
        },
        description: {
            value: 'Partner'
        }
    }
}

define root view entity ZCDX_C_BUSINESS_PARTNER
  as projection on ZCDX_BUSINESS_PARTNER
{



      @UI.facet: [
      {
        id: 'HeaderUserStatus',
        purpose: #HEADER,
        type: #DATAPOINT_REFERENCE,
        position: 10,
        targetQualifier: 'UserStatus'
      },
      {
        id: 'HeaderFacetBusinessPartner',
        type: #COLLECTION,
        label: 'Partner Details',
        targetQualifier: 'BP',
        position: 10
       },
       {
        id: 'SubFacetBasicData',
        purpose: #STANDARD,
        type: #FIELDGROUP_REFERENCE,
        parentId: 'HeaderFacetBusinessPartner',
        label: 'Basic Data',
        position: 10,
        targetQualifier: 'BASICDATA'
        },
        {
          id: 'SubFacetAddress',
          purpose: #STANDARD,
          type: #FIELDGROUP_REFERENCE,
          parentId: 'HeaderFacetBusinessPartner',
          label: 'Address',
          position: 20,
          targetQualifier: 'ADDRESS'
        },
       {
         id: 'TableBankDetails',
         purpose: #STANDARD,
         type: #LINEITEM_REFERENCE,
         label: 'Bank Details',
         position: 20,
         targetElement: '_BankDetails'
        },      
       {
         id: 'TableIDNumbers',
         purpose: #STANDARD,
         type: #LINEITEM_REFERENCE,
         label: 'Identification Numbers',
         position: 20,
         targetElement: '_IDNumbers'
        },
//       {
//       id: 'HeaderFacetIdentifikatioNumms',
//        purpose: #STANDARD,
//        type: #FIELDGROUP_REFERENCE,
//        label: 'Identifikation Nummbers',
//        targetQualifier: 'IDNUMS',
//        position: 25
//       },       
       {
       id: 'idFactSheet',
        purpose: #STANDARD,
        type: #FIELDGROUP_REFERENCE,
        label: 'Fact Sheet',
        targetQualifier: 'FACTSHEET',
        position: 15
       }
       ]

      @Search.defaultSearchElement: true
      @UI.lineItem: [{ position: 10, importance: #HIGH } ] //, {type: #FOR_ACTION, dataAction: 'generateDOX42', label: 'Generate Factsheet DOX42'}]
      @UI.selectionField: [{ position: 10 }]
      @UI.fieldGroup: [{ position: 10, qualifier: 'BASICDATA' } ]
      @UI.identification: [{type: #FOR_ACTION, dataAction: 'generateDOX42', label: 'Generate Factsheet DOX42'}]
      key Partner,

      @UI.lineItem: [{ position: 30, importance: #HIGH }]
      @UI.selectionField: [{ position: 30 }]
      @UI.fieldGroup: [{ position: 30, qualifier: 'BASICDATA' }]
      @Search.defaultSearchElement: true
      FirstName,
      @UI.lineItem: [{ position: 40, importance: #HIGH }]
      @UI.selectionField: [{ position: 40 }]
      @UI.fieldGroup: [{ position: 40, qualifier: 'BASICDATA' }]
      @Search.defaultSearchElement: true
      LastName,
      
      @Search.defaultSearchElement: true
      FullName,
      
      @UI.lineItem: [{ position: 50, importance: #HIGH, label: 'Street' }]
      @UI.fieldGroup: [{ position: 10, qualifier: 'ADDRESS', label: 'Street' }]
      @Search.defaultSearchElement: true
      StreetAndNr,

      @UI.lineItem: [{ position: 60, importance: #HIGH }]
      @UI.fieldGroup: [{ position: 20, qualifier: 'ADDRESS' }]
      @Search.defaultSearchElement: true
      PostCode,
      
      @UI.lineItem: [{ position: 70, importance: #HIGH }]
      @UI.selectionField: [{ position: 50 }]
      @UI.fieldGroup: [{ position: 30, qualifier: 'ADDRESS' }]
      @Search.defaultSearchElement: true
      City,
      
      @UI.lineItem: [{ position: 80, importance: #HIGH,  label: 'Country' }]
      @UI.fieldGroup: [{ position: 40, qualifier: 'ADDRESS', label: 'Country' }]
      Country,
            

      @UI.fieldGroup: [{ position: 20, qualifier: 'FACTSHEET', type: #WITH_URL, url: 'CustomerFactSheetLink' }]
      @UI.lineItem: [{ position: 90, importance: #HIGH, type: #WITH_URL, url: 'CustomerFactSheetLink' }]
      TextDownloadFactSheet,

      @UI.fieldGroup: [{ position: 10, qualifier: 'FACTSHEET' }]
      CustomerFactSheetTimestamp,

      @UI.hidden: true
      SecondsCreated,

      @UI.hidden: true
      CustomerFactSheetLink,

      @UI.hidden: true
      Type,

      @UI.hidden: true
      CriticalityCode,
     
      @UI.dataPoint: { qualifier: 'UserStatus', title: 'Status', criticality: 'CriticalityCode' }
      UserStatus,
      
      _BankDetails,
      _IDNumbers
}
