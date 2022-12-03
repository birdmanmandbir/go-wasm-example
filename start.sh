goexec 'http.ListenAndServe(`:9999`, http.FileServer(http.Dir(`.`)))'
