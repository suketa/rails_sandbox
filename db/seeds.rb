User.create(
  name: 'Matz',
  languages: Language.create(
    [
      { name: 'Ruby' }
    ]
  )
)

Company.create(
  name: 'Microsoft',
  languages: Language.create(
    [
      { name: 'C#' }
    ]
  )
)
