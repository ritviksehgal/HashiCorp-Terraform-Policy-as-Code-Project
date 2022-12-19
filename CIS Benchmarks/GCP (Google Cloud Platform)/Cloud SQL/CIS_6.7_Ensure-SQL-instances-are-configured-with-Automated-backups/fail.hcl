mock "tfplan/v2" {
  module {
    source = "/../../test/ensure-automatic-backup-is-enabled/mock-tfplan-fail.sentinel"
      }
    }
      
test {
  rules = {
    main = false
    }
  }