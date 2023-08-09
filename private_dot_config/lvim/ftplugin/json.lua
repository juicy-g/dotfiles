local json_opts = {
  settings = {
    json = {
      schemas = require('schemastore').json.schemas {
        select = {
          '.eslintrc',
          'package.json',
          'prettierrc.json',
          'tsconfig.json',
          'babelrc.json',
        },
      },
    },
  },
}

require('lvim.lsp.manager').setup('jsonls', json_opts)
