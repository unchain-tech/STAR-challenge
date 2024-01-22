module.exports = {
  tabWidth: 2,
  trailingComma: "all",
  singleQuote: false,
  semi: false,
  plugins: ["@trivago/prettier-plugin-sort-imports"],
  importOrder: ["^[./]", "^@/(.*)$"],
  importOrderSeparation: true,
  importOrderSortSpecifiers: true,
  importOrderGroupNamespaceSpecifiers: true,
  importOrderCaseInsensitive: true,
  overrides: [
    {
      files: "*.sol",
      options: {
        tabWidth: 4,
      },
    },
  ],
}
