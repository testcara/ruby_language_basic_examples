# Topologically sortable hash
# https://ruby-doc.org/stdlib-2.2.0/libdoc/tsort/rdoc/TSort.html

require 'tsort'

class TsortableHash < Hash
  include TSort
  alias tsort_each_node each_key

  def tsort_each_child(node, &block)
    # node is the object 
    # block is the dependent objects
    fetch(node).each(&block)
  end
end

class Errata
  def initialize(id, name, blocking_errata = [])
    @advisory_id = id
    @name = name
    @blocking_errata = blocking_errata
  end

  def set_blocking_errata(blocking_errata=[])
    @blocking_errata = blocking_errata
  end

  def get_blocking_errata()
    return @blocking_errata
  end

  def get_errata_name()
    return @name
  end
end

if __FILE__ == $0
  print "== Let us assume we have 4 advisories\n"
  print "== Note: ad is the abbreviation of the 'advisory'\n"
  print "== Prepare 4 ads: ad_1, ad_2, ad_3, ad_4\n"
  ad_1 = Errata.new(1, "ad_1")
  ad_2 = Errata.new(2, "ad_2")
  ad_3 = Errata.new(3, "ad_3")
  ad_4 = Errata.new(4, "ad_4")
  print "== Set the dependency relationship\n"
  print "== ad_3 is blocking ad_4, ad_4 is blocking ad_1, ad_1 is blocking ad_2\n"
  ad_2.set_blocking_errata([ad_1])
  ad_1.set_blocking_errata([ad_4])
  ad_4.set_blocking_errata([ad_3])
  print "== Run tsorted to sort the dependent ads\n"
  #print ad_1.get_blocking_errata(), ad_2.get_blocking_errata(), ad_3.get_blocking_errata(), ad_4.get_blocking_errata()
  data = TsortableHash[[ad_1, ad_2, ad_3, ad_4].map{|e| [e, e.get_blocking_errata()]}]
  #sorted_data = TsortableHash[[ad_1, ad_2].map{|e| [e, e.get_blocking_errata()]}]
  #print sorted_data
  sorted_data = data.tsort
  print "== The sorted ad are:\n"
  print sorted_data.map {|x| x.get_errata_name()}
  print "\n== Truely,['ad_3','ad_4','ad_1', 'ad_2'] is really what we expect\n"
  print "== Cheers!\n"
end
