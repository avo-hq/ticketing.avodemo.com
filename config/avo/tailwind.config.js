const avoPreset = require('../../tmp/avo/tailwind.preset.js')

module.exports = {
  presets: [avoPreset],
  content: [
    ...avoPreset.content,
    './app/views/**/*.html.erb',
    './app/components/**/*.{html.erb,rb}',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
  ]
}
