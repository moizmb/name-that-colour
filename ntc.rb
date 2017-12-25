#######################################################################
# Port of ntc.js originally created by Chirag Mehta                   #
# +-----------------------------------------------------------------+ #
# |                  http://chir.ag/projects/ntc                    | #
# |-----------------------------------------------------------------| #
# |               ntc js (Name that Color JavaScript)               | #
# +-----------------------------------------------------------------+ #
#                                                                     #
# This script is released under the: Creative Commons License:        #
# Attribution 2.5 http://creativecommons.org/licenses/by/2.5/         #
#######################################################################

require "./errors"
require "json"
$names = JSON.parse(File.read("./names.json"))

class Ntc
  attr_accessor :color

  def initialize(color)
    @color = color.upcase
    if @color.length < 3 || @color.length > 7
      raise InputError.new(@color), "Color must be in the form #RGB or #RRGGBB"
    end
    if @color.length % 3 == 0
      @color = "#" + @color
    end
    if @color.length == 4
      @color = "#" + @color[1] * 2 + @color[2] * 2 + @color[3] * 2
    end
  end

  # adopted from: Farbtastic 1.2
  # http://acko.net/dev/farbtastic
  def rgb
    [('0x' + @color[1..2]).to_i(16), ('0x' + @color[3..4]).to_i(16),('0x' + @color[5..6]).to_i(16)]
  end

  # adopted from: Farbtastic 1.2
  # http://acko.net/dev/farbtastic
  def hsl
    rgb = self.rgb.map {|v| v.to_f / 255}
    r, g, b = rgb

    min = [r, [g, b].min].min
    max = [r, [g, b].max].max
    delta = max - min
    l = (min + max) / 2

    s = 0
    if (l > 0) and (l < 1)
      s = delta / (l < 0.5 ? (2 * l) : (2 - 2 * l))
    end

    h = 0
    if delta > 0
      if (max == r && max != g)
        h += (g - b) / delta
      end
      if (max == g && max != b)
        h += (2 + (b - r) / delta)
      end
      if (max == b && max != r)
        h += (4 + (r - g) / delta)
      end
      h /= 6
    end

    return [(h * 255).to_i, (s * 255).to_i, (l * 255).to_i]
  end

  def name
    rgb = self.rgb
    r, g, b = rgb
    hsl = self.hsl
    h, s, l = hsl
    ndf1 = 0
    ndf2 = 0
    ndf = 0
    cl = -1
    df = -1

    $names.length.times do |i|
      if @color == "#" + $names[i][0]
        return ["#" + $names[i][0], $names[i][1], true]
      end
      ndf1 = (r - $names[i][2]) ** 2 + (g - $names[i][3]) ** 2 + (b - $names[i][4]) ** 2
      ndf2 = (h - $names[i][5]) ** 2 + (s - $names[i][6]) ** 2 + (l - $names[i][7]) ** 2
      ndf = ndf1 + ndf2 * 2
      if (df < 0) or (df > ndf)
        df = ndf
        cl = i
      end
    end

    if cl < 0
      raise InputError.new(@color), "Color must be in the form #RGB or #RRGGBB"
    else
      return ["#" + $names[cl][0], $names[cl][1], false]
    end
  end
end

