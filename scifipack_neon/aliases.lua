
function scifipack_neon.register_alias(dyecolor)
	minetest.register_alias("scifipack:linelight" .. dyecolor, "scifipack_neon:linelight" ..dyecolor)
	minetest.register_alias("scifipack:cornerlight" .. dyecolor, "scifipack_neon:cornerlight" ..dyecolor)
	minetest.register_alias("scifipack:stairlight" .. dyecolor, "scifipack_neon:stairlight" ..dyecolor)
end

scifipack_neon.register_alias("red")
scifipack_neon.register_alias("yellow")
scifipack_neon.register_alias("orange")
scifipack_neon.register_alias("green")
scifipack_neon.register_alias("cyan")
scifipack_neon.register_alias("blue")
scifipack_neon.register_alias("violet")
scifipack_neon.register_alias("magenta")
