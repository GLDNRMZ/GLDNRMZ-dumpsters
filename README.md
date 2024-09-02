# GLDNRMZ-dumpsters
Dumpster Diving and Trash Selling

Original dumpster script by [zf-labo](https://github.com/zf-labo/zf-dumpster-qb)

# Additions
* Search anything that looks like it contains trash
* Tier based loot system
* Trash items
* Sell trash items to any homeless ped
* Chance homeless ped steals your food and drugs
* Added ablity to store items in trash. Code snippets from [Jakers](https://jakers.tebex.io/package/4923802)

# Add Items to Shared lua
```
['cd'] 				             = {['name'] = 'cd', 			  	  	        ['label'] = 'Compact Disk', 		    ['weight'] = 50, 		['type'] = 'item', 		['image'] = 'cd.png', 		        ['unique'] = false, 	['useable'] = false,  	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Relic of the 90s'},
['newspaper'] 			 	     = {['name'] = 'newspaper', 			  		['label'] = 'Old Newspaper', 		    ['weight'] = 50, 		['type'] = 'item', 		['image'] = 'newspaper.png', 		['unique'] = false,		['useable'] = false,  	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Last weeks newspaper'},
['wrapper'] 			 	     = {['name'] = 'wrapper', 					    ['label'] = 'Used Food Wrapper', 		['weight'] = 50, 		['type'] = 'item', 		['image'] = 'wrapper.png', 		    ['unique'] = false,	    ['useable'] = false,  	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Up-N-Atom Burger wrapper'},
['rat'] 			   	         = {['name'] = 'rat', 					        ['label'] = 'Dead Rat', 		        ['weight'] = 50, 	    ['type'] = 'item', 		['image'] = 'rat.png', 		        ['unique'] = false,	    ['useable'] = false, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Stinky dead rat'},
['roach'] 			 	         = {['name'] = 'roach', 					    ['label'] = 'Cockroach', 		        ['weight'] = 50, 		['type'] = 'item', 		['image'] = 'roach.png', 		    ['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'A live cockroach'},
['gum'] 				 	     = {['name'] = 'gum', 			  	  		    ['label'] = 'Empty Pack of Gum', 		['weight'] = 50, 		['type'] = 'item', 		['image'] = 'gum.png', 			    ['unique'] = false, 	['useable'] = false,  	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Its empty'},
['napkin'] 				         = {['name'] = 'napkin', 			  	        ['label'] = 'Greasy Napkin', 			['weight'] = 50, 		['type'] = 'item', 		['image'] = 'napkin.png', 	        ['unique'] = false, 	['useable'] = false,  	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Napkin with leftover ketchop'},
['safetypin'] 				     = {['name'] = 'safetypin', 			  	  	['label'] = 'Broken Safety Pin', 	    ['weight'] = 50, 		['type'] = 'item', 		['image'] = 'safetypin.png', 		['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Broken Safety Pin'},
['scrapwood'] 			 	     = {['name'] = 'scrapwood', 					['label'] = 'Broken Peice of Wood', 	['weight'] = 50, 		['type'] = 'item', 		['image'] = 'scrapwood.png', 		['unique'] = false,		['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Karate chopped wood'},
['cardboard'] 			 	     = {['name'] = 'cardboard', 					['label'] = 'Ripped Cardboard', 	    ['weight'] = 50, 		['type'] = 'item', 		['image'] = 'cardboard.png', 		['unique'] = false,		['useable'] = false,  	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Ripped Cardboard'},
['ducttape'] 				     = {['name'] = 'ducttape', 			  	  	    ['label'] = 'Duct Tape', 		        ['weight'] = 50, 		['type'] = 'item', 		['image'] = 'ducttape.png', 		['unique'] = false, 	['useable'] = false,  	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Roll of Duct Tape'},
['wires'] 			 	         = {['name'] = 'wires', 			  		    ['label'] = 'Electrical Wires', 		['weight'] = 50, 		['type'] = 'item', 		['image'] = 'wires.png', 		    ['unique'] = false,		['useable'] = false,  	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Torn Electrical Wires'},
```
	
# Add Images to Inventory Script

# Change config.lua Options and Items to Fit Your Servers Needs.

# Dependencies:
* [qb-core](https://github.com/qbcore-framework/qb-core)
* [qb-target](https://github.com/qbcore-framework/qb-target)

# Optional Dependencies:
* [ps-dispatch](https://github.com/Project-Sloth/ps-dispatch)
* [memorygame](https://github.com/pushkart2/memorygame)
* [qb-lock](https://github.com/YishengCheww/qb-lock)
* [ps-ui](https://github.com/Project-Sloth/ps-ui)
