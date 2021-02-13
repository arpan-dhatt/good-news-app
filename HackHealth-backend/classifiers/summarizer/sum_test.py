
text_to_summarize = "After receiving the support of the largest group in parliament, the Five Star Movement, " \
                    "Mr Draghi now has backing across the broad political spectrum. It means he will have a large " \
                    "enough majority to push through his agenda. A senior figure in the Five Star Movement, " \
                    "Luigi Di Maio, will stay on as foreign minister in his cabinet. Meanwhile, Giancarlo Giorgetti, " \
                    "a senior figure in the populist far-right League party, will be industry minister. Andrea " \
                    "Orlando, from the centre-left Democratic Party, will be labour minister. The government faces a " \
                    "confidence vote next week - a formality given its cross-party backing. An economist with " \
                    "experience at the highest levels of the European Union and as governor of the Bank of Italy, " \
                    "Mr Draghi is being seen as a safe pair of hands. "
summary = model.predict(text_to_summarize, num_summary_sentences=2)

print(summary)