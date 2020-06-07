#ifndef MORPHCLOCK_H
#define MORPHCLOCK_H

#include <QLCDNumber>

//! [0]
class MorphClock : public QLCDNumber
{
    Q_OBJECT

public:
    MorphClock(QWidget *parent = nullptr);

signals:
        void incSec();

private slots:
    void showTime();
};
#endif
