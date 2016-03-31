// Tattoomatic
// by Zarqon

import <zlib.ash>

int buypartsupto = 1000;

// load outfit data from Wiki (1 tattoo name, 2 image filename, 3 outfit name)
vprint("Loading tattoo data...",5);
string outfitdata = excise(visit_url("http://kol.coldfront.net/thekolwiki/index.php/Tattoos"),"Outfit Tattoos","</table>");
if (outfitdata == "")
  {
    print("Error fetching outfit data from the Wiki.");
    exit;
  }
matcher tatbits = create_matcher("\\<td\\>.+?title=\\\"(.+?)\\\".+?img alt=\\\"(.+?)\\\" src.+?title=\\\"(.+?)\\\".+?\\<\\/td\\>",outfitdata);
string mytats = visit_url("account_tattoos.php");
string chunk;
int have,tot;

boolean get_tat(string duds) {
   if (!have_outfit(duds)) foreach n,it in outfit_pieces(duds) {
      if (have_item(it) < 1) {
         if (!is_tradeable(it) || mall_price(it) > buypartsupto) {
           chunk += "<a href='http://kol.coldfront.net/thekolwiki/index.php/"+it+"'><img src='../images/itemimages/"+it.image+"' height=20 width=20 border=0></a>&nbsp;"+it+(is_tradeable(it) ? " @ "+rnum(mall_price(it))+entity_decode("&micro;") : " (non-tradeable)")+"<br>";
           continue;
         }
      }
      if (!retrieve_item(1,it)) return vprint("Unable to acquire outfit piece: "+it,-3);
   }
   if (!have_outfit(duds)) return false;
   outfit(duds);
   return (!contains_text(visit_url("place.php?whichplace=town_wrong&action=townwrong_artist_quest"),"your clothing is so bland"));
}

boolean [string] outfits;

while (tatbits.find()) {
   chunk = ""; tot += 1;
   //  || get_tat(tatbits.group(3)))
   outfits[tatbits.group(3)] = false;
   if (contains_text(mytats,"/"+to_lower_case(tatbits.group(2))))
   {
     outfits[tatbits.group(3)] = true;
     print(entity_decode("&#10004;")+" "+tatbits.group(1)+" ("+tatbits.group(3)+")","green");
     have += 1;
   }
   else
   {
     print(entity_decode("&empty;")+" "+tatbits.group(1)+" ("+tatbits.group(3)+")");
   }
   if (chunk != "") print_html("<div style='clear:both; padding-left: 15px'>"+chunk+"</div>");
}
vprint("Tattoo checking complete.  You have "+have+" / "+tot+" outfit tattoos.","blue",2);
