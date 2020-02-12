-- ToME - Tales of Maj'Eyal
-- Copyright (C) 2009 - 2019 Nicolas Casalini
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
--
-- Nicolas Casalini "DarkGod"
-- darkgod@te4.org

base_size = 64

local shader = false
local oversize = 1.1
local speed = 0
local a = 1
local basesize = (shader and 1.75 or 1) * 2 * radius * (engine.Map.tile_w + engine.Map.tile_h) / 2 + engine.Map.tile_w * 1.8 * (oversize or 1)
local appear = 0
local appear_size = 3
local r = 1
local g = 1
local b = 1

local limit_life = 16
local grow = basesize / limit_life

local nb = empty_start and -1 or 0

return {
	blend_mode = shader and core.particles.BLEND_SHINY or nil,
	system_rotation = base_rot or rng.range(0, 360), system_rotationv = speed,
	generator = function()
	if nb == -1 then
		return {
			trail = 0,
			life = empty_start,
			size = 1, sizev = 0, sizea = 0,

			x = (x or 0) * 64, xv = 0, xa = 0,
			y = (y or 0) * 64, yv = 0, ya = 0,
			dir = 0, dirv = dirv, dira = 0,
			vel = 0, velv = 0, vela = 0,

			r = 0, rv = 0, ra = 0,
			g = 0, gv = 0, ga = 0,
			b = 0, bv = 0, ba = 0,
			a = 0, av = 0, aa = 0,
		}
	elseif nb == 0 and appear > 0 then
		return {
			trail = 0,
			life = appear,
			size = basesize * appear_size, sizev = -basesize * (appear_size - 1) / appear, sizea = 0,

			x = (x or 0) * 64, xv = 0, xa = 0,
			y = (y or 0) * 64, yv = 0, ya = 0,
			dir = 0, dirv = dirv, dira = 0,
			vel = 0, velv = 0, vela = 0,

			r = r, rv = 0, ra = 0,
			g = g, gv = 0, ga = 0,
			b = b, bv = 0, ba = 0,
			a = a, av = 0, aa = 0,
		}
	else
		return {
			trail = 0,
			life = limit_life or 1000,
			size = grow and 0 or basesize, sizev = grow, sizea = 0,

			x = (x or 0) * 64, xv = 0, xa = 0,
			y = (y or 0) * 64, yv = 0, ya = 0,
			dir = 0, dirv = dirv, dira = 0,
			vel = 0, velv = 0, vela = 0,

			r = r, rv = 0, ra = 0,
			g = g, gv = 0, ga = 0,
			b = b, bv = 0, ba = 0,
			a = a, av = 0, aa = 0,
		}
	end
end, },
function(self)
	if ((appear > 0 and nb < 2) or (appear == 0 and nb < 1)) or not limit_life then
		if self.ps:emit(1) > 0 then
			nb = nb + 1
		end
	end
end, 1, "particles_images/ice_nova"