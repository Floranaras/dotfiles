return {
    {
        "NvChad/nvim-colorizer.lua",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            filetypes = { "*" },
            user_default_options = {
                tailwind = true,
                RGB = true,
                RRGGBB = true,
                names = false,
                RRGGBBAA = true,
                rgb_fn = true,
                hsl_fn = true,
                css = true,
                css_fn = true,
                mode = "background",
                virtualtext = "■",
            },
        },
    },

    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
        },
        opts = function(_, opts)
            local format_kinds = opts.formatting and opts.formatting.format

            opts.formatting = opts.formatting or {}
            opts.formatting.format = function(entry, item)
                if format_kinds then
                    format_kinds(entry, item)
                end
                return require("tailwindcss-colorizer-cmp").formatter(entry, item)
            end

            return opts
        end,
    },
}
