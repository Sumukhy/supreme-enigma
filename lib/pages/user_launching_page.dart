import 'package:flutter/material.dart';

class UserGuidelinesPage extends StatelessWidget {
  const UserGuidelinesPage({Key? key}) : super(key: key);

  static Map<String, String> guidelinesMap = {
    'Head': """
Keep the person still. The injured person should lie down with the head and shoulders slightly elevated. Don't move the person unless necessary, and avoid moving the person's neck. If the person is wearing a helmet, don't remove it.
Stop any bleeding. Apply firm pressure to the wound with sterile gauze or a clean cloth. But don't apply direct pressure to the wound if you suspect a skull fracture.
Watch for changes in breathing and alertness. If the person shows no signs of circulation — no breathing, coughing or movement — begin CPR.
Head trauma that results in concussion symptoms, such as nausea, unsteadiness, headaches or difficulty concentrating, should be evaluated by a medical professional.

""",
    "Hand": """
Apply direct pressure until bleeding stops.
Remove rings and bracelets that may slow blood flow or compress nerves if swelling happens later.
Clean area with warm water and soap.
Apply antibiotic ointment and a sterile bandage.
Apply ice and elevate hand to reduce swelling.
If a finger or part of a finger has been cut off, collect all parts and tissue and put it in a plastic bag on ice for transport to the hospital.
See a health care provider immediately for a deep cut, puncture wound, animal bite, human bite, or a scrape that you can’t get clean, or if the cut shows signs of infection.

For Sprains,fingers dislocation or fracture:Apply ice to reduce swelling.
Keep the finger elevated above the heart.
If the finger is bent or deformed, don't try to straighten it.
See a doctor immediately.
""",
    "Face": """
Apply pressure with a clean cloth or bandage for several minutes to stop bleeding. Protect the eyes from any soap or antiseptics you may need to use on the wound. Wash the cut area well with soap and water. Don't scrub the wound.
Remove any dirt particles from the area and let the water from the faucet run over it for several minutes. A dirty cut or scrape that isn't fully cleaned can cause scarring and infection.
For a lot of bleeding, press on the wound firmly for 10 to 15 minutes with a clean cloth. Don't stop to look at the cut. If the cloth becomes soaked with blood, put a new cloth on top of the old cloth. Don't lift the first cloth. Facial wounds often bleed heavily.
Apply an antiseptic lotion or cream, or petroleum jelly.
Cover the area with an adhesive bandage or gauze pad. Change the dressing often.
Check the area each day and keep it clean and dry.
Don't blow on the wound. This can cause germs to grow.
For bruises, blisters, or swollen areas caused by injury: Place an ice pack or cold pack on the area every 1 to 2 hours for 10 to 15 minutes. Do this for the first 24 hours. To make an ice pack, put ice cubes in a plastic bag that seals at the top. Wrap this in a thin, clean cloth or towel. Don't put ice directly against the skin. 
Use a sunscreen with sun protection factor (SPF) of at least 15 or higher on healed cuts and wounds. This is to help prevent scarring.
""",
    "Stop any bleeding": """
If they’re bleeding, elevate and apply pressure to the wound using a sterile bandage, a clean cloth, or a clean piece of clothing.
Immobilize the injured area: If you suspect they’ve broken a bone in their neck or back, help them stay as still as possible. If you suspect they’ve broken a bone in one of their limbs, immobilize the area using a splint or sling.
Apply cold to the area: Wrap an ice pack or bag of ice cubes in a piece of cloth and apply it to the injured area for up to 10 minutes at a time.
Treat them for shock: Help them get into a comfortable position, encourage them to rest, and reassure them. Cover them with a blanket or clothing to keep them warm.
"""
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Virtual First Aid Guidelines'),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return ExpansionTile(
                title: Text(
                  '${index + 1}. ${guidelinesMap.keys.elementAt(index)}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                children: <Widget>[
                  Text(
                      guidelinesMap['${guidelinesMap.keys.elementAt(index)}']!),
                ],
              );
            },
            itemCount: guidelinesMap.length,
          ),
        ));
  }
}
