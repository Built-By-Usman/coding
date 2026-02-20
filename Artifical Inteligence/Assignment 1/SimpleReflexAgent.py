import random

class SimpleReflexAgent:
    def __init__(self):
        self.action = ['Suck','MoveLeft','MoveRight','DoNothing']
    

    def perceive(self,environment):

        location=environment['location']
        status=environment['rooms'][location]

        return location,status
    def act(self,percept):
        location,status=percept

        if status=="Dirty":
            return "Suck"
        elif location=='A':
            return "MoveLeft"
        elif location=="B":
            return "MoveRight"
        else:
            return "DoNothing"











environment = {
    'rooms':{'A':random.choice(['Clean','Dirty']),
             'B':random.choice(['Clean','Dirty'])
             },
             'location':random.choice(["A","B"])
}

agent=SimpleReflexAgent()
steps=5


print("Initial Environment:",environment)



for step in range(5):
    percept=agent.perceive(environment)
    action=agent.act(percept)


    print(f"Step {step+1}:Agent at {percept[0]},Room is {percept[1]},Action:{action}")


    if action=="Suck":
        environment['rooms'][percept[0]]='Clean'
    elif action=="MoveLeft":
        environment['location']="B"
    elif action=="MoveRight":
        environment['location']="A"


print("Final environment:",environment)
    