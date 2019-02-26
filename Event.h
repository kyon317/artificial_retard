
#pragma once 


typedef enum etype { arrival, departure } EventType;


// Desc:  Represents a simulation event
class Event {
    private:
    EventType eventType;
    int time;
    int length;


    public:
        //Desc:  Constructors
        Event()
        {
            time = -1;
            length = -1;
        }
        Event(const Event&e)
        {
            this->eventType = e.getType();
            this->time = e.getTime();
            this->length = e.getLength();
        }

        //Desc:  Getters
        EventType getType()const{return this->eventType;}
        int getTime()const{return this->time;}
        int getLength()const{return this->length;}

        //Desc:  Setters
        void setType(const EventType &t){this->eventType = t;}
        void setTime(const int &t){this->time = t};
        void setLength(const int &t){this->length = t;}




        // Desc:  Comparators
        bool operator<(const Event &r) const { return  ; };
        bool operator>(const Event &r) const { return /* complete this */ ; };
        bool operator<=(const Event &r) const { return /* complete this */ ; };
        bool operator>=(const Event &r) const { return /* complete this */ ; };

        // Desc:  Overload Operator
        friend ostream& operator<<(ostream &output,const Event &e)
        {
            if(this->getType()==arrival)output<<"Event: Arrival";
            else
                output<<"Event: Departure";
            output<<this->getTime();
            output<<this->getLength();
            return output;
        }
}; // Event

