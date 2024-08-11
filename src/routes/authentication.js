const express = require('express');
const router = express.Router();
const passport = require('passport');
const { isLoggedIn } = require('../lib/auth');
const { check, validationResult } = require('express-validator');

// SIGNUP
router.get('/signup', (req, res) => {
  res.render('./../views/auth/signup.hbs');
});

router.post('/signup', passport.authenticate('local.signup', {
  successRedirect: '/profile',
  failureRedirect: '/signup',
  failureFlash: true
}));

// SIGNIN
router.get('/signin', (req, res) => {
  res.render('./../views/auth/signin.hbs');
});

router.post('/signin', [
  check('username', 'Username is Required').notEmpty(),
  check('password', 'Password is Required').notEmpty()
], (req, res, next) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    req.flash('message', errors.array()[0].msg);
    console.log(errors.array()[0].msg);
    return res.redirect('/signin');
  }
  passport.authenticate('local.signin', {
    successRedirect: '/profile',
    failureRedirect: '/signin',
    failureFlash: true
  })(req, res, next);
});

// LOGOUT
router.get('/logout', (req, res, next) => {
  req.logOut((err) => {
    if (err) {
      return next(err);
    }
    res.redirect('/signin');
  });
});

// PROFILE
router.get('/profile', isLoggedIn, (req, res) => {
  res.render('profile');
});

module.exports = router;