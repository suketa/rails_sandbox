const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      keyframes: {
        fadeToOriginal: {
          '0%': { backgroundColor: '#ff9999' },
          '100%': { backgroundColor: 'transparent' } // 元の背景色
        },
      },
      animation: {
        fadeToOriginal: 'fadeToOriginal 3s ease-in-out forwards', // 3秒の遷移で一度だけ実行
      },
    },
  },
plugins: [
  require('@tailwindcss/forms'),
  require('@tailwindcss/typography'),
  require('@tailwindcss/container-queries'),
]
}
