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

void main()
{
  malus = check_wads()
}
