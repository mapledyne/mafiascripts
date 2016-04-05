int numSuggestions = 3;

int mucho = 999999999;
string bullet = "&#8226;&nbsp;";
string tab_bullet = "&nbsp;&nbsp;&nbsp;&#8226;&nbsp;";

int [int] suggestions;

record outTat
{
	string tatName;
	string outName;
	boolean own;
	boolean have_outfit;
	int cost;
	string suggestion;
	boolean checked;
} [int] tattooStatus;

string [int] invOut;

tattooStatus[0].outName = "8-Bit Finery";
tattooStatus[1].outName = "Antique Arms And Armor";
tattooStatus[2].outName = "Arrrbor Day Apparrrrrel";
tattooStatus[3].outName = "Arboreal Raiment";
tattooStatus[4].outName = "Black Armaments";
tattooStatus[5].outName = "Bounty-Hunting Rig";
tattooStatus[6].outName = "Bow Tux";
tattooStatus[7].outName = "BRICKOfig Outfit";
tattooStatus[8].outName = "Bugbear Costume";
tattooStatus[9].outName = "Cloaca-Cola Uniform";
tattooStatus[10].outName = "Clockwork Apparatus";
tattooStatus[11].outName = "Crimbo Duds";
tattooStatus[12].outName = "Crimborg Assault Armor";
tattooStatus[13].outName = "Cursed Zombie Pirate Costume";
tattooStatus[14].outName = "Dire Drifter Duds";
tattooStatus[15].outName = "Dwarvish War Uniform";
tattooStatus[16].outName = "Dyspepsi-Cola Uniform";
tattooStatus[17].outName = "El Vibrato Relics";
tattooStatus[18].outName = "Encephalic Ensemble";
tattooStatus[19].outName = "eXtreme Cold-Weather Gear";
tattooStatus[20].outName = "Fancy Tux";
tattooStatus[21].outName = "Filthy Hippy Disguise";
tattooStatus[22].outName = "Floaty Fatigues";
tattooStatus[23].outName = "Frat Boy Ensemble";
tattooStatus[24].outName = "Frat Warrior Fatigues";
tattooStatus[25].outName = "Frigid Northlands Garb";
tattooStatus[26].outName = "Furry Suit";
tattooStatus[27].outName = "Glad Bag Glad Rags";
tattooStatus[28].outName = "Gnauga Hides";
tattooStatus[29].outName = "Grass Guise";
tattooStatus[30].outName = "Grimy Reaper's Vestments";
tattooStatus[31].outName = "Hodgman's Regal Frippery";
tattooStatus[32].outName = "Hot and Cold Running Ninja Suit";
tattooStatus[33].outName = "Hyperborean Hobo Habiliments";
tattooStatus[34].outName = "Knight's Armor";
tattooStatus[35].outName = "Knob Goblin Elite Guard Uniform";
tattooStatus[36].outName = "Knob Goblin Harem Girl Disguise";
tattooStatus[37].outName = "Legendary Regalia of the Chelonian Overlord";
tattooStatus[38].outName = "Legendary Regalia of the Groovelord";
tattooStatus[39].outName = "Legendary Regalia of the Master Squeezeboxer";
tattooStatus[40].outName = "Legendary Regalia of the Pasta Master";
tattooStatus[41].outName = "Legendary Regalia of the Saucemaestro";
tattooStatus[42].outName = "Legendary Regalia of the Seal Crusher";
tattooStatus[43].outName = "Mining Gear";
tattooStatus[44].outName = "Mutant Couture";
tattooStatus[45].outName = "OK Lumberjack Outfit";
tattooStatus[46].outName = "Palmist Paraphernalia";
tattooStatus[47].outName = "Pork Elf Prizes";
tattooStatus[48].outName = "Primitive Radio Duds";
tattooStatus[49].outName = "Pyretic Panhandler Paraphernalia";
tattooStatus[50].outName = "Radio Free Regalia";
tattooStatus[51].outName = "Roy Orbison Disguise";
tattooStatus[52].outName = "Slimesuit";
tattooStatus[53].outName = "Snowman Suit";
tattooStatus[54].outName = "Star Garb";
tattooStatus[55].outName = "Swashbuckling Getup";
tattooStatus[56].outName = "Tapered Threads";
tattooStatus[57].outName = "Tawdry Tramp Togs";
tattooStatus[58].outName = "Terrifying Clown Suit";
tattooStatus[59].outName = "Terrycloth Tackle";
tattooStatus[60].outName = "Time Trappings";
tattooStatus[61].outName = "Tropical Crimbo Duds";
tattooStatus[62].outName = "Vestments of the Treeslayer";
tattooStatus[63].outName = "Vile Vagrant Vestments";
tattooStatus[64].outName = "War Hippy Fatigues";
tattooStatus[65].outName = "Wumpus-Hair Wardrobe";
tattooStatus[66].outName = "Yendorian Finery";
tattooStatus[67].outName = "Topiaria";

int item_count(item it) {
   int counter = item_amount( it ) + closet_amount( it ) + storage_amount( it ) + display_amount ( it ) + equipped_amount ( it );
   return counter;
}

boolean has_it(string outfit)
{
	item [int] outfit_parts = outfit_pieces(outfit);
	foreach doodad in outfit_parts
	{
		if (item_count(outfit_parts[doodad]) == 0)
		{
			return false;
		}
	}
	return true;
}

void possessedTats( )
{
	string tattooList = visit_url( "account_tattoos.php" );
	for i from 0 to count( tattooStatus ) - 1
	{
		tattooStatus[i].have_outfit = has_it(tattooStatus[i].outName);
		if( contains_text( tattooList , outfit_tattoo(tattooStatus[i].outName) ) )
		{
			tattooStatus[i].own = true;
			tattooStatus[i].checked = true;
		}
	}
}

void print_suggestions()
{
	for x from 0 to numSuggestions
	{
		int suggestion = suggestions[x];
		if (suggestion == -1)
			continue;

			print_html(tattooStatus[suggestion].suggestion);
			print("");
	}

}

void addSuggestion(int tattoo, string suggestion)
{
	for x from 0 to numSuggestions
	{
		if (suggestions[x] == tattoo)
		{
			return;
		}
	}
	for x from 0 to numSuggestions
	{
		if (suggestions[x] == -1)
		{
			suggestions[x] = tattoo;
			tattooStatus[tattoo].suggestion = bullet + suggestion;
			tattooStatus[tattoo].checked = true;
			return;
		}
	}
}

void ownedOutfits()
{
	for i from 0 to count( tattooStatus ) - 1
	{
		if ( tattooStatus[i].have_outfit && !tattooStatus[i].own )
		{
			tattooStatus[i].checked = true;
			addSuggestion(i, "You own the outfit <font color='green'>" + tattooStatus[i].outName + "</font>. Put it on and go to the artist to get the tattoo!");

		}
	}
}

void mallOutfits()
{
	int costs = mucho;
	int targetOutfit = -1;

	for i from 0 to count( tattooStatus ) - 1
	{
		tattooStatus[i].cost = mucho;
		if (tattooStatus[i].own || tattooStatus[i].have_outfit)
			continue;

		foreach key,doodad in outfit_pieces(tattooStatus[i].outName)
		{
			if (!is_tradeable(doodad))
			{
				// reset cost back to "lots" in case one item is tradeable and one isn't.
				tattooStatus[i].cost = mucho;
				break;
			}
			tattooStatus[i].checked = true;
			if (tattooStatus[i].cost == mucho)
			{
				tattooStatus[i].cost = 0;
			}
			if (item_count(doodad) == 0)
			{
				tattooStatus[i].cost += mall_price(doodad);
			}
			if (tattooStatus[i].cost > costs)
				break;
		}
		if (tattooStatus[i].cost > costs || tattooStatus[i].cost == mucho)
			continue;
		costs = tattooStatus[i].cost;
		targetOutfit = i;
	}
	if (targetOutfit == -1)
		return;
	string sug = "The outfit parts for <font color='green'>" + tattooStatus[targetOutfit].outName + "</font> are available for " + costs + " meat in the mall.<br>Pieces to buy:<br>";

	item [int] stuff = outfit_pieces(tattooStatus[targetOutfit].outName);
	foreach x in stuff
	{
		if (item_count(stuff[x]) == 0)
		{
			sug += tab_bullet + stuff[x] + "<br>";
		}
	}
	addSuggestion(targetOutfit, sug);
}

void arrrborDay()
{
	int arrrbor = 2;
	tattooStatus[arrrbor].checked = true;
	if (tattooStatus[arrrbor].own)
		return;
	// Pete 4 == Arrrbor day == day 59
	int day = gameday_to_int();
	if (day < 60 && day > 54)
	{
		addSuggestion(arrrbor, "Arrrbor day approaches. You should endeavor to get a new piece of <font color='green'>" + tattooStatus[arrrbor].outName + "</font>.");
	}
}


void buyableParts(int outfit, item part, boolean mall)
{

	tattooStatus[outfit].checked = true;
	if (tattooStatus[outfit].own)
		return;
	int price = 0;
	if (mall)
	{
		price = mall_price(part);
	}
	int cost = 0;
	item [int] outfit_parts = outfit_pieces(tattooStatus[outfit].outName);
	foreach doodad in outfit_parts
	{
		if (item_count(outfit_parts[doodad]) == 0)
		{
			int price = sell_price(outfit_parts[doodad].seller, outfit_parts[doodad]);
			cost += price;
		}
	}
	int own = item_count(part);
	int need = cost - own;
	if (need <= 0)
	{
		string sug = "You have enough " + part + " to complete the <font color='green'>" + tattooStatus[outfit].outName + "</font>.<br>Buy the missing pieces:<br>";
		item [int] stuff = outfit_pieces(tattooStatus[outfit].outName);
		foreach x in stuff
		{
			if (item_count(stuff[x]) == 0)
			{
				sug += tab_bullet + stuff[x] + "<br>";
			}
		}
		addSuggestion(outfit, sug);
	} else {
		string sug = "You're " + need + " " + part + " away from the <font color='green'>" + tattooStatus[outfit].outName + "</font>.<br>Get these pieces:<br>";
		item [int] stuff = outfit_pieces(tattooStatus[outfit].outName);
		foreach x in stuff
		{
			if (item_count(stuff[x]) == 0)
			{
				sug += tab_bullet + stuff[x] + "<br>";
			}
		}
		if (mall)
		{
			sug += part + " can be bought in the mall for " + price + " meat. The total cost would run you " + (price*need) + " meat.<br>";
		}
		addSuggestion(outfit, sug);
	}

}

void buyableParts(int outfit, item part)
{
	buyableParts(outfit, part, true);
}


void classOutfits()
{
	for x from 37 to 42
	{
		tattooStatus[x].checked = true;
	}
	int outfit = -1;
	switch(my_class())
	{
		case $class[seal clubber]:
			outfit = 42;
			break;
		case $class[turtle tamer]:
			outfit = 37;
			break;
		case $class[disco bandit]:
			outfit = 38;
			break;
		case $class[accordion thief]:
			outfit = 39;
			break;
		case $class[pastamancer]:
			outfit = 40;
			break;
		case $class[sauceror]:
			outfit = 41;
			break;
	}
	if (outfit<0)
		return;

	if (!tattooStatus[outfit].own)
	{
		addSuggestion(outfit,"You don't have the <font color='green'>" + tattooStatus[outfit].outName + "</font> outfit, but you can get it this ascension by killing your nemesis.");
	}
}

void check_suggestions(boolean always_exit)
{
	for x from 0 to numSuggestions
	{
		if (suggestions[x] == -1 && !always_exit)
			return;
	}
	print_suggestions();
	print( "Tattoo review complete." , "green" );
	exit;
}

void check_suggestions()
{
	check_suggestions(false);
}


void main( )
{
	for i from 0 to numSuggestions
	{
		suggestions[i] = -1;
	}
	possessedTats();

	ownedOutfits();
	check_suggestions();

	classOutfits();
	check_suggestions();

	arrrborDay();
	check_suggestions();

	mallOutfits();
	check_suggestions();

	buyableParts(67, $item[topiary nugglet]);  // topiaria
	check_suggestions();

	buyableParts(13, $item[cursed piece of thirteen]); // cursed zombie
	check_suggestions();

	buyableParts(5, $item[filthy lucre]); // bounty hunting
	check_suggestions();

	for i from 0 to count( tattooStatus ) - 1
	{
		if (!tattooStatus[i].checked)
		{
			print("not checked: " + tattooStatus[i].outName);
		}
	}

	check_suggestions(true);
}
