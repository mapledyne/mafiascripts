int i_a(string name) {
	item i = to_item(name);
	int a = item_amount(i) + closet_amount(i) + equipped_amount(i);

	//Make a check for familiar equipment NOT equipped on the current familiar.
	foreach fam in $familiars[] {
		if (have_familiar(fam) && fam != my_familiar()) {
			if (name == to_string(familiar_equipped_equipment(fam)) && name != "none") {
				a = a + 1;
			}
		}
	}

	//print("Checking for item "+name+", which it turns out I have "+a+" of.", "fuchsia");
	return a;
}

boolean check_wads() {
  // if we don't have access to the Malus, there isn't much to do
  if (my_class() != $class[seal clubber] && my_class() != $class[turtle tamer])
    return false;
  // don't have access to the Malus currently, but may later.
  if (! have_skill($skill[pulverize]))
    return false;

  item tnug = $item[twinkly nuggets];
  item tpow = $item[twinkly powder];
  boolean ret = false;

  if (item_amount(tnug) > 4) {
    ret = true;
    print ('You can convert twinkly nuggets to wads.');
  }
  if (item_amount(tpow) > 4) {
    ret = true;
    print ('You can convert twinkly powder to nuggets.');
  }

  return ret;
}

boolean check_meatcar() {
  // we already have the car
  if (item_amount($item[bitchin' meatcar]) > 0)
    return false;
  print ('Go get a meatcar.');
  return true;
}

boolean check_keys() {
  boolean ret = false;
  if (my_buffedstat(my_primestat()) > 20) {
    if (i_a("boris's key") == 0)
    {
      ret = true;
      print("* Need Boris's key.");
    }
    if (i_a("jarlsberg's key") == 0)
    {
      ret = true;
      print("* Need Jarlsberg's key.");
    }
    if (i_a("sneaky pete's key") == 0)
    {
      ret = true;
      print("* Need Sneaky Pete's key.");
    }
    if (ret && i_a("fat loot token") > 0) {
      print(">>> You have a fat loot token to buy one.");
    }
		if (ret && i_a("fat loot token") == 0) {
      print(">>> Adventure in the daily dungeon to get one.");
    }

  }
  if (i_a("steam-powered model rocketship") > 0) {
    if (i_a("richard's star key") == 0)
    {
      ret = true;
      print("* Need Richard's star's key.");
      int s = i_a("star");
      if (s < 8) {
        print (">>> Need " + (8 - s) + " star(s)");
      }
      s = i_a("line");
      if (s < 7) {
        print (">>> Need " + (7 - s) + " star(s)");
      }
      if (i_a("star chart") == 0) {
        print (">>> Need a star chart.");
      }
    }
  }
  return ret;
}

boolean check_boat() {
  boolean [item] boats;
  boats[$item[dingy dinghy]] = item_amount($item[dingy dinghy]) > 0;

  foreach b in boats {
    if (boats[b]) {
      // we have a boat:
      return false;
    }
  }
  print ('You don\'t have a boat. Consider getting one.');
  return true;
}

int clover_cost() {
  // estimate the cost of a clover:
  item gum = $item[chewing gum on a string];
  int cost = npc_price(gum);
  item trinket = $item[worthless trinket];
  item gewgaw = $item[worthless gewgaw];
  item knick = $item[worthless knick-knack];

  if ((item_amount(trinket) + item_amount(gewgaw) + item_amount(knick)) > 0) {
    print('To reduce clover cost, put your worthless items in the closet.');
    print('This script assumes you\'ll do this, and will calculate accordingly.');
  }
  int own = 0;
  if (i_a("old sweatpants") > 0)
    own = own + 1;
  if (i_a("stolen accordion") > 0)
    own = own + 1;
  if (i_a("mariachi hat") > 0)
    own = own + 1;
  if (i_a("disco ball") > 0)
    own = own + 1;
  if (i_a("disco mask") > 0)
    own = own + 1;
  if (i_a("saucepan") > 0)
    own = own + 1;
  if (i_a("[Hollandaise helmet") > 0)
    own = own + 1;
  if (i_a("pasta spoon") > 0)
    own = own + 1;
  if (i_a("ravioli hat") > 0)
    own = own + 1;
  if (i_a("turtle totem") > 0)
    own = own + 1;
  if (i_a("helmet turtle") > 0)
    own = own + 1;
  if (i_a("seal-skull helmet") > 0)
    own = own + 1;
  if (i_a("seal-clubbing club") > 0)
    own = own + 1;

  return cost;
}

boolean check_clovers() {
  //Hermit clovers
  string body = visit_url("/hermit.php");

  if(contains_text(body,"left in stock")) {
    print("You can still get hermit clovers today");
    return true;
  }
  return false;
}

void main()
{
  boolean clovers = check_clovers();
  boolean malus = check_wads();
  boolean meatcar = check_meatcar();
  if (!meatcar) {
    boolean boat = check_boat();
  }
  boolean keys = check_keys();

  print('Complete.');
}
