return {
  {
    "folke/which-key.nvim", -- Plugin existant qu'on utilise pour pas avoir d'erreur
    keys = { "<F1>", "gh" },
    config = function()
      -- Notre fonction header 42 custom
      local function insert_42_header()
        local filename = vim.fn.expand("%:t")
        if filename == "" then
          filename = "unnamed.c"
        end

        local login = "yasmine.aichi" -- 🔥 TON LOGIN
        local email = "yasmine.aichi@learner.42.tech" -- 🔥 TON EMAIL
        local date = os.date("%Y/%m/%d %H:%M:%S")

        -- Calcul des espaces pour alignement parfait
        local function pad_to_length(str, target_length)
          local padding = target_length - #str
          if padding > 0 then
            return str .. string.rep(" ", padding)
          end
          return str
        end

        -- Construction du header avec alignement exact
        local header = {
          "/* ************************************************************************** */",
          "/*                                                                            */",
          "/*                                                        :::      ::::::::   */",
          "/*   " .. pad_to_length(filename, 51) .. ":+:      :+:    :+:   */",
          "/*                                                    +:+ +:+         +:+     */",
          "/*   By: "
            .. login
            .. " <"
            .. email
            .. ">"
            .. string.rep(" ", math.max(0, 42 - #login - #email - 3))
            .. "+#+  +:+       +#+        */",
          "/*                                                +#+#+#+#+#+   +#+           */",
          "/*   Created: "
            .. date
            .. " by "
            .. login
            .. string.rep(" ", math.max(0, 18 - #login))
            .. "#+#    #+#             */",
          "/*   Updated: "
            .. date
            .. " by "
            .. login
            .. string.rep(" ", math.max(0, 18 - #login))
            .. "###   ########.fr       */",
          "/*                                                                            */",
          "/* ************************************************************************** */",
          "",
        }

        -- Insérer au début du fichier
        vim.api.nvim_buf_set_lines(0, 0, 0, false, header)
        print("✅ Header 42 inséré pour " .. filename)
      end

      -- Créer la commande
      vim.api.nvim_create_user_command("Header42", insert_42_header, {
        desc = "Insert 42 header",
      })

      -- Keymaps
      vim.keymap.set("n", "<F1>", insert_42_header, { desc = "42 Header" })
      vim.keymap.set("n", "gh", insert_42_header, { desc = "42 Header (quick)" })

      print("✅ Header 42 custom configuré !")
    end,
  },
}
