return {
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({
                "*",
                css = { rgb_fn = true },
                html = { names = false },
            }, {
                RGB = true,
                RRGGBB = true,
                names = true,
                RRGGBBAA = true,
                rgb_fn = true,
                hsl_fn = true,
                css = true,
                css_fn = true,
                mode = "background",
            })
        end,
    },
}
