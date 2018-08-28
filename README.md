# Information
Ntc is a Ruby port of the javascript library [ntc.js](http://chir.ag/projects/ntc). Ntc will give you the name of the closest defined color from Resene RGB Values list, Wikipedia, Crayola, and Color-Name Dictionaries.

# Basic Usage
Ntc can be used as

```ruby
require "./ntc"

color = Ntc.new("#000000")
# #<Ntc:0x00000001a63758 @color="#000000">

color.name
# ["#000000", "Black", true]

color_rgb = color.name[0] # RGB value of the closest match
# "#000000"
color_name = color.name[1] # Name of closest match
# "Black"
color_exactmatch = color.name[2] # True if exact color match
# true
```


# License
* The [ntc library](https://github.com/moizmb/name-that-colour) is released under the [Creative Commons license](https://creativecommons.org/licenses/by/2.5/).
* The algorithm and design is copyrighted to Chirag Mehta, 2007.
