mock "tfplan/v2" {
  module {
    source = "/../../test/ensure-ssh-is-restricted-from-internet/mock-tfplan-fail.sentinel"
      }
    }
      
test {
  rules = {
    main = false
      }
    }