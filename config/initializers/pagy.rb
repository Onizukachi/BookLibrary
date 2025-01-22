require 'pagy/extras/bootstrap'
require 'pagy/extras/overflow'

Pagy::DEFAULT[:limit] = 5 # items per page
Pagy::DEFAULT[:overflow] = :empty_page