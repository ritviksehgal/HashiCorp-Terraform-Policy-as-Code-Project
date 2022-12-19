mock "tfplan/v2" {
  module {
    source = "/../../test/ensure-automatic-backup-is-enabled/mock-tfplan-pass.sentinel"
      }
    }
      
test {
  rules = {
    main = true
    }
  }