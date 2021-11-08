module.exports = (req, res, next) => {
  res.header('X-Server', 'json-restify');
  next()
}