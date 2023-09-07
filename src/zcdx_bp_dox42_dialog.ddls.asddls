@EndUserText.label: 'Abstract entity to extend the validity'
@Metadata.allowExtensions: true
define abstract entity zcdx_bp_dox42_dialog 
 // with parameters parameter_name : parameter_type 
  {
    extend_till : abap.string( 300 );
    comments : abap.string( 300 );
    
}
