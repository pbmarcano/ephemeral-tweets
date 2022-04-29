const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],

  theme: {
    extend: {
      colors: {
        'ts-turquoise': '#50d6d9',
        'ts-blue': '#2f2771',
        'ts-white': '#d9f8f8',
      },
      fontFamily: {
        'display': ['Poppins', ...defaultTheme.fontFamily.sans],
      }
    }
  },

  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/aspect-ratio'),
  ],
}
