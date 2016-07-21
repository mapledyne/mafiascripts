boolean is_avatar_potion( item it )
{
    return it.effect_modifier( "Effect" ).string_modifier( "Avatar" ) != "";
}

boolean has_avatar_active()
{
  int [effect] currentEffects = my_effects(); // Array of current active effects
  foreach buff in currentEffects{
    if (buff.string_modifier( "Avatar" ) != "")
    {
      return true;
    }
  }
  return false;
}

void main()
{
  int[item] inventory = get_inventory() ;
  foreach it in inventory
  {
    if (is_avatar_potion(it))
    {
      put_closet(inventory[it], it);
    }
  }
  // if we already have an avatar potion active, bail.
  if (has_avatar_active())
  {
//    return;
  }

  foreach it in item
  {
    print(it);
  }
  inventory = cl() ;
  int[item] potions;
  foreach it in inventory
  {
    if (is_avatar_potion(it))
    {
      potions[it] = inventory[it];
    }
  }
  foreach it in potions
  {
//    print(it);
  }
}
