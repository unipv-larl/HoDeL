var queryParams={};
queryParams["orderby"]="lemma";
queryParams["dir"]="asc";
var requestLemma={};
//var cats = ['argsCard', 'argsSet', 'argsCase', 'filler', 'fillerRel', 'relOrderType', 'relOrderCat', 'relOrderSubCat'];
//var cats = ['argsCard', 'argsSet', 'argsCase', 'filler', 'fillerRel', 'relOrderType', 'relOrderCat', 'relOrderSubCat', 'curArgLem', 'curArgRel', 'curArgCas'];
var relOrderCats=['relOrderCatSb', 'relOrderCatObj', 'relOrderCatPnom', 'relOrderCatOComp'];
var cats1 = ['argsCard', 'argsSet', 'argsCase', 'filler', 'fillerRel', 'relOrderType', 'relOrderCat', 'relOrderSubCat', 'curArgLem', 'curArgRel', 'curArgCas', 'filter'];
var cats = cats1.concat(relOrderCats);
   
function setFilter() {
//   queryParams["update"]= 1;
//aggiorna tabella verbi o argomenti:
   queryParams["update"] = $("#tabella").hasClass("args-table") ? 3 : 1;   
   queryParams["filter"]= $("#filter").val();
}
function getOrderBy() {
   $(".orderby").each(function() {
       if ($(this).hasClass("asc")) {
          queryParams["orderby"]= $(this).attr("id");
          queryParams["dir"]= "asc";
       }  
       if ($(this).hasClass("desc")) {
          queryParams["orderby"]= $(this).attr("id");
          queryParams["dir"]= "desc";
       }  
   });
}

function showCategory(catParam){
//  queryParams={}; //reset parametri
//  setFilter();
//  getOrderBy();

  for (p in cats ) { delete queryParams[cats[p]]; }
  $("#filter").val('');
  for(key in catParam) {
     queryParams[key] = catParam[key];
  }
  delete queryParams["lemma"];
  queryParams["update"]= 1;
  queryParams["page"]=1; 
/* *** modifica: vedi query.js 
  $("#center").load(listURI, queryParams);
  $("#lemma-catNavigation:visible").hide(500);
  $("#center-toolbar:hidden").show();
*/
  if (queryParams["Slemma"]) { // se è stato selezionato un lemma
                               // mostrane le reificazioni
     showLemma(catParam);
  } else {
     $("#center").load(listURI, queryParams);
     $("#lemma-catNavigation:visible").hide(500);
     $("#center-toolbar:hidden").show();
  }
/*****/
  return false;
}

function showCategoryPage(page){
  if (page) {  queryParams["page"]=page; }
  queryParams["update"]= 1;
  $("#center").load(listURI, queryParams);
  $("#center-toolbar:hidden").show();
  return false;
}

//mostra occorrenze del lemma
function showLemma(catParam){
  if (catParam) {
     for (p in cats ) { delete queryParams[cats[p]]; } //reset parametri
     for(key in catParam) {
        queryParams[key] = catParam[key];
     }
  }
  if ( requestLemma.lemma ) { 
  queryParams["lemma"]=requestLemma.lemma; 
  }
  queryParams["page"]=1; 
  $("#center").load(showLemmaURI, queryParams);
  return false;
}

function showLemmaPage(page){
  queryParams["page"]=page;
  $("#center").load(showLemmaURI, queryParams);
  return false;
}

function updLemma(){
$("#lemma-categories li.cat-item, #lemma-fillers li.cat-item").each(function(){
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

 $('#lemma-catNavigation.catGroup .catGroupHead').addClass('roundBottom').next().hide();

}


$(document).ready(function(){

   $('#filter').live('keydown', function(event) {
     if ( event.keyCode == '13' ) {
        setFilter();
        $("#center").load(listURI, queryParams );
     }
   });

   $(".orderby").live("click", function(event){
        var id=$(this).attr("id");
        queryParams["orderby"]=id; 
        if ( $(this).hasClass("asc") ) { 
           $(this).removeClass("asc"); 
           $(this).addClass("desc");
           $(this).prev().html("<span>[&or;]</span>");
           queryParams["dir"]="desc"; 
        }
        else if ($(this).hasClass("desc")) { 
           $(this).removeClass("desc"); 
           $(this).addClass("asc"); 
           $(this).prev().html("<span>[&and;]</span>");
           queryParams["dir"]="asc"; 
        }
        else { 
           $(this).parent().find(".orderby").each(function(){ if ( $(this).attr("id")!=id ) {
                                                                     $(this).removeClass("desc");
                                                                     $(this).removeClass("asc");
                                                                $(this).prev().html("<span>[&nbsp;]</span>");
                                                                     }
                                                      });
           $(this).addClass("asc"); 
           $(this).prev().html("<span>[&and;]</span>");
           queryParams["dir"]="asc"; 
        }
        setFilter();
        $("#center").load(listURI, queryParams);
   });


   $(".lemmaLink").live("click", function(event){
     requestLemma["lemma"]=$(this).text();
     showLemma();
     $("#lemma-catNavigation").load(catIndexTreeURI, {lemma: $(this).text()},
     function(){ updLemma();} );
     $("#lemma-catNavigation:hidden").show(600);
     $("#center-toolbar:visible").hide();
     return false;
   });

   $(".verb").live("click", function(event){
     requestLemma["lemma"] = pageTokens[$(this).attr('id')].lemma;
     queryParams={};
     showLemma();
     $("#lemma-catNavigation").load(catIndexTreeURI, {lemma: requestLemma["lemma"]},
     function(){ updLemma();} );
//     $("#lemma-catNavigation:hidden").show();
     $("#center-toolbar:visible").hide();
     return false;
   });

   $("#sel-lemma").live("click", function(event){
     queryParams={};
     showLemma();
//     $("#lemma-catNavigation:hidden").show(500);
     $("#center-toolbar:visible").hide();
     return false;
   });

   $("#num-categories > li.cat-item, #order-categories li.cat-item, #lemma-categories li.cat-item, #lemma-fillers li.cat-item, #args-catNavigation li.cat-item").each(function(){
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

  $('.catGroup .catGroupHead').live("click", function() {
      $(this).next().toggle();
      $(this).toggleClass('roundBottom');
      return false;
   }).addClass('roundBottom').next().hide();

 });      

