pairs = ["028B_030B", "028B_061B", "028B_089B", 
         "028B_wustl", "030B_061B", "030B_089B", 
         "030B_wustl", "061B_089B", "061B_wustl", 
         "089B_wustl", "pbuccae_028B", "pbuccae_030B",
         "pbuccae_061B", "pbuccae_089B", "pbuccae_wustl",
         "pbuccae_pbuccalis", "pbuccalis_028B", "pbuccalis_030B",
         "pbuccalis_B061B", "pbuccalis_089B", "pbuccalis_wustl"]

for x in pairs:
    print """
<link %s>
ribbon = yes 
file = ../formatted_input/%s.links
bezier_radius = 0r
radius = 0.999r
thickness = 10p 
color = %s_a5
</link>""" % (x, x, x.lower())

