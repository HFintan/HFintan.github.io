!/usr/bin/python
print('Content-type: text/html\r\n\r')

from __future__ import division
import math
import random

def first_guess(actual_rating):
    """
    This function has you play 10 games to calculate a ballpark estimated 
    rating from ten games, which can be then input in to find_rating for 
    fine-tuning.
    """
    score=0
    total_opp_rating=0
    for i in range(0,10):
         opponent_rating = random.randint(1000, 2000)
         z=fight(actual_rating,opponent_rating)
         score=score+z
         total_opp_rating=total_opp_rating+opponent_rating
         print "Your opponent for this round has a rating of %d" % opponent_rating
         if z==1:
                print "You win!"
         if z==0:
                print "You lose!"
    r=(total_opp_rating+400*(2*score-10))/10
    print "The first guess at your rating after ten preliminary games is %d" % r
    return r

def fight(rating1,rating2):
    """
    This function pits two players against each other and returns 0 if the
    second player wins, and 1 if the first player wins. The result of the fight     will be 'random' but weighted, according to the players ratings, so that a 
    higher rating increases your winning chances.
    """
    L = []
    # We use the two for loops below to create a list L from which we pick an 
    # element at random.
    # There are rating1 chances of the first player winning, and rating2 chances    # of him/her losing.
   # This corresponds to the fact that the greater the rating advantage, the
    # greater the chance of winning. We ignore ties.

    for x in range(0, int(10**(rating1 / 400))):
        L.append(1)
    for y in range(0, int(10**(rating2 / 400))):
        L.append(0)

    # This will be a 1 if our protagonist wins, and a 0 if s/he loses.
    return random.choice(L)

def find_rating(actual_rating, number_of_games,kvalue,decrement):
    """
    This function first uses first_guess to gain a ballpark estimate, then 
    runs number_of_games iterations of find_rating_once to fine-tune the
    estimated rating for the player.
    """
    guess=first_guess(actual_rating)
    estimated_rating=guess
    while number_of_games > 0:
        estimated_rating = find_rating_once(actual_rating,
                                            estimated_rating,
                                            kvalue,
                                            decrement)
        number_of_games -= 1
        kvalue -= decrement
        print "Number of remaining games: %d" % number_of_games
        print "-" * 10 + "\n"
    print "The first guess at your rating was %d, but after further games, your estimated rating is\n" % guess
    return int(estimated_rating)


def find_rating_once(actual_rating, estimated_rating, kvalue, decrement):
    """
    This function inputs the actual and estimated ratings of some hypothetical
    new player, who is pitted against an opponent whose rating is already
    established (it is actually just a randomly generated integer within 500 
    points either side of his/her estimated rating) and his/her estimated_rating
    is adjusted depending on whether s/he wins or loses. We hope that it will
    not take too long for the estimated_rating to converge to the actual_rating.
   not take too long for the estimated_rating to converge to the actual_rating.
    """
    if kvalue < 10:
        # This is the k-value - a number which decreases the more games a 
        # player plays (the idea is that the change in a player's estimated             # rating swings more wildly for the first few games, as the system 
        # tries to find his/her
        # approximate strength, before settling down as the approximation to
        # actual_rating is approached) - a simplified version is provided here.
        # Fine-tuning of this k-value is needed. Starting at 40 is, I think,
        # standard, and what I have used for my simulations.
        kvalue = 10

    # This is the opponent.
    opponent_rating = random.randint(int(estimated_rating-500), int(estimated_rating+500))
    print "Your opponent for this round has a rating of %d" % opponent_rating

    L = []
    # We use these two to create a list from which we pick an element at random
    # There are actual_rating chances of winning, and opponent_rating chances
    # of losing
    # This corresponds to the fact that the greater the rating advantage, the
    # greater the chance of winning. We ignore ties.
    # Obviously, we use the actual_rating rather than the estimated_rating,
    # because that is the level a player plays at.
    for x in range(0, int(10**(actual_rating / 400))):
        L.append(1)
    for y in range(0, int(10**(opponent_rating / 400))):
        L.append(0)

        # This will be a 1 if our protagonist wins, and a 0 if s/he loses.
    z = random.choice(L)

    new_estimated_rating = math.ceil(
        estimated_rating + kvalue * (
            z - (
                1 / (
                    1 + 10**(
                        (opponent_rating - estimated_rating) / 400
                    )
                )
            )
        )
    ) # This is, approximately, the Elo formula.

    if z == 0:
        zz = estimated_rating - new_estimated_rating
        print "Loss. You just lost %d points. Better luck next time.\n" % zz
    if z == 1:
        zz = new_estimated_rating - estimated_rating
        print "Congratulations! You just gained %d points.\n" % zz

    print "Your estimated rating is now %s ." % new_estimated_rating
    return new_estimated_rating
