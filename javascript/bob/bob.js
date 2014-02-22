var Bob = function() {
  this.hey = function(message){
    if(isSilence(message)){
      return "Fine. Be that way!";
    }
    if(isAllCaps(message)){
      return "Woah, chill out!";
    }
    if(isQuestion(message)){
      return "Sure.";
    }
    return "Whatever.";
  };

  function isAllCaps(message){
    return message == message.toUpperCase() && /[A-Z]/.test(message);
  }

  function isQuestion(message){
    return message.charAt(message.length - 1) == '?';
  }

  function isSilence(message){
    return message.trim() == "";
  }
};
module.exports = Bob;
