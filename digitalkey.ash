boolean [string] numeric_modifiers;

string effect_type = "Item Drop";

class class_modifier( item it )
{
    return to_class( string_modifier( it, "Class" ) );
}

effect intrinsic_modifier( item it )
{
    return to_effect( string_modifier( it, "Effect" ) );
}

float effect_modifiers( effect ef )
{
    float mod = numeric_modifier( ef, effect_type );
    if (mod == 0.0)
      return mod;
    return mod;
}

void skill_modifiers( skill sk )
{
    print( "" );
    print( "Skill: " + sk );
    foreach name in numeric_modifiers
    {
        float mod = numeric_modifier( sk, name );
        if ( mod != 0.0 )
            print( "    " + name + ": " + mod );
    }
}

float item_modifiers( item it )
{
    float mod = numeric_modifier( it, effect_type );
    class cl = class_modifier( it );
    if ( cl != $class[none] && my_class() != cl)
      return 0.0;
    effect ie = intrinsic_modifier( it );
    float e_mod = 0.0;
    if ( ie != $effect[none] )
    {
        e_mod = effect_modifiers( ie );
    }
    return mod + e_mod;
}

void current_modifiers()
{
    print( "" );
    print( "Current modifiers" );
    foreach name in numeric_modifiers
    {
        float mod = numeric_modifier( name );
        if ( mod != 0.0 )
            print( "    " + name + ": " + mod );
    }
}

void main() {
  effect eff;
  foreach doodad in get_inventory() {
     float mod = item_modifiers( doodad );
     if (mod > 0)
     {
      print (doodad + " gives " + mod);
     }

  }
  boolean has_loot_skill = false;
  if (have_skill($skill[Fat Leon's Phat Loot Lyric]))
    has_loot_skill = true;
  if (has_loot_skill && have_effect($effect[Fat Leon's Phat Loot Lyric]) == 0)
  {
    print("You should cast Fat Leon's Phat Loot Lyric.");
  }

}
