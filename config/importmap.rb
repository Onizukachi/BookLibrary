# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin 'chart.js', to: 'https://ga.jspm.io/npm:chart.js@4.3.0/dist/chart.js'
pin '@kurkle/color', to: 'https://ga.jspm.io/npm:@kurkle/color@0.3.2/dist/color.esm.js'