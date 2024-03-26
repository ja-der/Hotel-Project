const express = require('express')
const app = express()
const port = 3001

app.listen(port, () => {
  console.log(`App running on port ${port}.`)
})

//await client.connect()
//const res = await
// client.query('SELECT * FROM laboratories.artist;')
// console.log(res.rows)
// await client.end()