
var REL=['Sb', 'Obj', 'Pnom', 'OComp'];
var SrelOrderCats=['SrelOrderCatSb', 'SrelOrderCatObj', 'SrelOrderCatPnom', 'SrelOrderCatOComp'];
var selCats1 = ['Slemma', 'SargsCard', 'SargsSet', 'SrelOrderSubCat', 'Sdiatesi', 'ScurArgLem', 'ScurArgRel', 'ScurArgCas'];
var selCats = selCats1.concat(SrelOrderCats);

var relOrderCats=['relOrderCatSb', 'relOrderCatObj', 'relOrderCatPnom', 'relOrderCatOComp'];

//var selArgsFields = ['SfillerLem', 'SfillerRelation', 'SfillerCase', 'SfillerRelPos'];
var selArgsFields = ['SfillerLem', 'SfillerRelation', 'SfillerCase', 'SfillerRelPos', 'SfillerPrep', 'SfillerConj'];

var options = {
    numTimes: 1,
    maxFields: 4,
    maxFieldsMsg: 'You have reached the maximum number of arguments allowed',
    fadeDuration: 'slow',
    deleteButtonDiv: 'delete-button-div',
    deleteButtonClass: 'delete-button',
    deleteButtonValue: 'Delete This Argument'
}

function anyArgs(){
   any=0;
   for ( i=0; i<4; i++ ) {
       any_i=0; 
       for ( p in selArgsFields ) { 
           if ( queryParams[ selArgsFields[ p ] + i ] ) { any_i++;} 
       }
       if ( any_i ) { any++ }
   }
   return any;
}

function anySelection(){
   any = 0;
   for (p in selCats ) { 
       if ( queryParams[ selCats[p] ] ) { any++;} 
   }
   any = any + anyArgs();
   return any;
}

function showArgsCategory(catParam){
  for (p in cats ) { delete queryParams[cats[p]]; }
  for(key in catParam) {
     queryParams[key] = catParam[key];
  }
  delete queryParams["lemma"];
  queryParams["update"]= 3;
  queryParams["page"]=1; 

/*  if (queryParams["Slemma"]) { // se è stato selezionato un lemma
                               // mostrane le reificazioni
     showLemma(catParam);
  } else { */
     $("#center").load(listURI, queryParams);
     $("#center-toolbar:hidden").show();
     $("#filter").val('');
//  }
/*****/
  return false;
}

function showArgsCategoryPage(page){
  if (page) {  queryParams["page"]=page; }
  queryParams["update"]= 3;
  $("#center").load(listURI, queryParams);
  $("#center-toolbar:hidden").show();
  return false;
}

function updFilter() {
   for (p in cats ) { 
       delete queryParams[ cats[p] ];  
   }
   any=0;
   for (p in selCats ) { 
       if ( $("#" + selCats[p] ).val() ) { queryParams[ selCats[p] ] = $("#" + selCats[p] ).val(); any++;} 
       else { delete queryParams[ selCats[p] ]; } 
   }

   queryParams["update"]= 2;

   //query attiva?
   if ( any ) { 
      $("#query-conditions").show();
   } else {
      $("#query-conditions").hide();
   }
}

function unSelect(all) {
   if (all) {
      for (p in selCats ) { 
         delete queryParams[ selCats[p] ];  
      }
      //elimina argomenti
      for ( i=0; i<4; i++ ) {
          for ( p in selArgsFields ) { 
              delete  queryParams[ selArgsFields[ p ] + i ];
           }
      }
      queryParams[ "cardinality" ] = 0;
      delete  queryParams[ "seq" ];
      delete  queryParams[ "card" ];
   } else {
      $("input.cat-unselector:not(:checked)").each(function(){
          delete queryParams[$(this).attr('name')];
      });
      $("input.arg-field-unselector:not(:checked)").each(function(){
          delete queryParams[$(this).attr('name')];
      });
      $("input.arg-list-unselector:not(:checked)").each(function(){
          delete queryParams[$(this).attr('name')];
      });
   }
//annulla eventuali browse filters
   for (p in cats ) { delete queryParams[cats[p]]; }

   queryParams["page"]= 1;
   queryParams["update"]= 2;
   if ( queryParams["Slemma"] ) {  // se è stato selezionato un lemma mostra reificazioni
       $("#content").load(showLemmaURI, queryParams, function(){ updIdx(); 
            $("#center-toolbar:visible").hide(); queryParams["update"] = 0; } );
       }
   else {
       $("#content").load( listURI, queryParams, function(){updIdx();} );
   }
   return false;
}

function getSelection() {
   $("input.cat-selector:checked").each(function(){
       queryParams[$(this).attr('name')]=$(this).val();
   });
   //recupera input hidden i.e. relationtype
   $("input.cat-selector:checked").parents("li.cat-item").children("input:hidden").each(function(){
       queryParams[$(this).attr('name')]=$(this).val();
   });
   queryParams["update"]= 2;
   if ( queryParams["Slemma"] ) {  // se è stato selezionato un lemma mostra reificazioni
       $("#content").load(showLemmaURI, queryParams, function(){ updIdx(); 
            $("#center-toolbar:visible").hide(); queryParams["update"] = 0; } );
       }
   else {
       $("#content").load( listURI, queryParams, function(){updIdx();} );
   }
   return false;
}

function setFilterValues() {
   for (p in selCats ) { 
       $("#" + selCats[p] ).val( queryParams[ selCats[p] ] ? queryParams[ selCats[p] ]: "");
   }
   setQueryValues();
}

function setQueryValues() {  //reimposta voliri della query:
   value = queryParams[ "Slemma" ] || '';
   $("#Slemma").val( value );
   
   value = queryParams[ "Sdiatesi" ] || '';
   $("#Sdiatesi").val( value );

   $('#addButton1').dynamicForm(options);
//   queryParams[ 'card' ] = $("[name='card']:checked").val() || '';
//   queryParams[ 'seq' ] = $("[name='seq']:checked").val() || '';
   cardinality = queryParams[ 'cardinality' ];
   for (i=1; i<cardinality; i++) {
        $('#addButton1').trigger('click');
   }
   for (p in selArgsFields ) { 
       $('.args-fields :[name^=' + selArgsFields[p] + ']').each(function(index) {
//           $(this).val( queryParams[ selArgsFields[p] + index ] );
           value = queryParams[ selArgsFields[p] + index ] || '';
           $(this).val( value );
       });
   }
/*   for (p in selArgsFields ) { 
       $('.args-fields :[name^=' + selArgsFields[p] + ']').each(function(index) {
           queryParams[ selArgsFields[p] + index ] = $(this).val();
           cardinality++;
       });
   }
*/
}


function updIdx() {
   //aggiorna lista categorie
   $("#num-categories > li.cat-item, #order-categories li.cat-item, #args-catNavigation li.cat-item").each(function(){
    var item;
    if ( $(this).has("ul").length ) {   
      item = $("<span class='plus'>+</span>").click(function(e){
        $(this)
          .text( $(this).text() === "+" ? "-" : "+" )
          .parent().next().toggle();
        return false;
      });
  
      $(this).find(".children").hide();
    } else {
      item = $("<span class='plus'>&nbsp;</span>");
    }
  
    $(this).children("a").prepend( item );
  });

  // chiudi categorie
  $('.catGroup .catGroupHead').addClass('roundBottom').next().hide();

  //chiudi form
  $("#query-form-div").hide();

  //visualizza constraints?
  if ( anySelection() ) { 
     $("#query-conditions").show();
     $("#query-form-header").removeClass('roundBottom');
  } else {
     $("#query-conditions").hide();
     $("#query-form-header").addClass('roundBottom');
  }

  //non visualizzare conto dei lemmi se c'è un lemma selezionato
  queryParams["Slemma"] ? $("#lemmataCount").hide() :  $("#lemmataCount").show();


  setFilterValues();
  
  // menu' di deselezione
  $("input.cat-unselector:not(:checked)").length ? $("#unselectsel").show() : $("#unselectsel").hide();

  // 'elmina' scelte obbligate
  $("li.cat-item > input[type='radio'].cat-selector").parent("li:only-child").children("input[type='radio'].cat-selector").hide();
}

function selectLemma( lemma ){
  queryParams["Slemma"] = lemma; 
  queryParams["page"] = 1; 
  queryParams["update"] = 2; 
  $("#content").load(showLemmaURI, queryParams, function(){ updIdx(); $("#center-toolbar:visible").hide();
      queryParams["update"] = 0; } );
  return false;
}

function selectArgLemma( lemma ){
  queryParams["ScurArgLem"] = lemma; 
  queryParams["page"] = 1; 
  queryParams["update"] = 2; 
  if (queryParams["Slemma"]) {
     $("#content").load(showLemmaURI, queryParams, function(){ updIdx(); $("#center-toolbar:visible").hide();
      queryParams["update"] = 0; } );
  }
  else {
     $("#content").load(listURI, queryParams, function(){ updIdx(); $("#center-toolbar:hidden").show();
      $("#filter").val(''); queryParams["update"] = 0; } );
  }
  return false;
}

function resetForm() {
  $("#Slemma").val( '' );
  $("#Sdiatesi").val( '' );
  $("[name='card']:checked").removeAttr("checked");
  $("[name='seq']:checked").removeAttr("checked");
  $('#addButton1').dynamicForm(options);
  for (p in selArgsFields ) { 
      $('.args-fields :[name^=' + selArgsFields[p] + ']').each(function(index) {
          $(this).val( '' );
      });
  }
}

$(document).ready(function(){
  $.loading({onAjax:true, img:spinningIMG, align:'center', delay: 100});
//  $.loading({onAjax:true, text:'prendi un caffe...'});
  //reset form query:
  resetForm();
  $("#query-form-div").hide();
  $("#query-conditions").hide();

  $("#query-form-header").live("click", function(event) {
     $("#query-form-div").toggle();
     $("#query-conditions").toggle();

     if ( ! $("#query-form-div").is(":visible") && anySelection() ) { 
       $("#query-conditions").show();
     } else {
       $("#query-conditions").hide();
     }
     
     if ( $("#query-form-div").is(":visible") || $("#query-conditions").is(":visible") ) { 
       $(this).removeClass('roundBottom');
     } else {
       $(this).addClass('roundBottom');
     }

     return false;
  }).addClass('roundBottom');

  $("#resetQueryButton").live('click', function(event) {
      resetForm();} )

  $("#queryButton").live('click', function(event) {
    $("#query-form-div").hide();

    updFilter();


//argomenti:
   queryParams[ 'card' ] = $("[name='card']:checked").val() || '';
   queryParams[ 'seq' ] = $("[name='seq']:checked").val() || '';
   cardinality=0;
   for (p in selArgsFields ) { 
       $('.args-fields :[name^=' + selArgsFields[p] + ']').each(function(index) {
           queryParams[ selArgsFields[p] + index ] = $(this).val();
           cardinality++;
       });
   }
   queryParams[ 'cardinality' ] = cardinality / 6;


    if ( queryParams["Slemma"] ) {  // se è stato selezionato un lemma mostra reificazioni
       $("#content").load(showLemmaURI, queryParams, function(){ updIdx(); 
            $("#center-toolbar:visible").hide(); queryParams["update"] = 0; } );
    }
    else {
       $("#content").load( listURI, queryParams, function(){updIdx();} );
    }
    return false;
  });

   $("a.lemma").live("click", function(event){
     selectLemma( $(this).text() );
     return false;
   });

   $("a.argument1").live("click", function(event){
     selectArgLemma( $(this).text() );
     return false;
   });

   $(".verb1").live("click", function(event){
     queryParams={};
     selectLemma( pageTokens[$(this).attr('id')].lemma );
     return false;
   });
   
//   $('#SargsSet').dependent({ parent:'SargsCard', group: 'argsUOCat' });

//categories selectors
   $("input:checked").removeAttr("checked");

   $("li.cat-item input.cat-selector").live("change", function(){
       $(this).parents("li.cat-item").children("input").attr('checked', true);
       $(this).parent("li.cat-item").siblings("li.cat-item").find("input.cat-selector").attr('checked', false);
       getSelection();
   });

//categories and arguments un-selectors
   $("input.cat-unselector").live("change", function(){
       $(this).parent("li").children("ul").children("li").children("input.cat-unselector").removeAttr("checked");
       $("#unselectsel:hidden").show();
   });

   $("input.arg-field-unselector, input.arg-list-unselector").live("change", function(){
       $("#unselectsel:hidden").show();
   });

   $("input.arg-unselector").live("change", function(){
       $(this).parent("li").find("input.arg-field-unselector").removeAttr("checked");
       $("#unselectsel:hidden").show();
   });

   $("#unselectall").live('click', function(event){
     unSelect( 1 );
     return false;
   }); 
   $("#unselectsel").live('click', function(event){
     unSelect( 0 );
     return false;
   }).hide(); 

   $("#filter").val('');
//dynForm
//    $('#addButton1').dynamicForm(options);


});      

