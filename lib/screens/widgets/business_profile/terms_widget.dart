import 'package:flutter/material.dart';
import 'package:project_fourth/screens/widgets/homepage/bottom_navigation_widget.dart';

class Terms extends StatelessWidget {
  const Terms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Terms of Service',
          style: TextStyle(
            color: Color(0xff4B4B87),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const BottomNavigation(initialIndex: 0),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(left: 16),
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('lib/assets/Back1.png'),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF1F5F9),
      body: const Padding(
        padding:  EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Retail Helper App',
                      style: TextStyle(
                        color: Color(0xff4B4B87),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                     SizedBox(height: 10),
                    Text(
                      "Terms of service (also known as terms of use and terms and conditions, commonly abbreviated as TOS or ToS, ToU or T&C) are the legal agreements between a service provider and a person who wants to use that service. The person must agree to abide by the terms of service in order to use the offered service.[1] Terms of service can also be merely a disclaimer, especially regarding the use of websites. Vague language and lengthy sentences used in these terms of service have caused concerns about customer privacy and raised public awareness in many ways.\n\nUsage\nA terms of service agreement is mainly used for legal purposes by companies which provide software or services, such as web browsers, e-commerce, web search engines, social media, and transport services.\nA legitimate terms of service agreement is legally binding and may be subject to change.[2] Companies can enforce the terms by refusing service. Customers can enforce by filing a lawsuit or arbitration case if they can show they were actually harmed by a breach of the terms. There is a heightened risk of data going astray during corporate changes, including mergers, divestitures, buyouts, downsizing, etc., when data can be transferred improperly.[3]\n\nContent[edit]\nA terms of service agreement typically contains sections pertaining to one or more of the following topic:\nDisambiguation/definition of keywords and phrases\nUser rights and responsibilities\nProper or expected usage; definition of misuse\nAccountability for online actions, behavior, and conduct\nPrivacy policy outlining the use of personal data\nPayment details such as membership or subscription fees, etc.\nOpt-out policy describing procedure for account termination, if available\nSometimes contains an Arbitration clause detailing the dispute resolution process and limited rights to take a claim to court\nDisclaimer/Limitation of liability, clarifying the site's legal liability for damages incurred by users\nUser notification upon modification of terms, if offered\nAmong 102 companies marketing genetic testing to consumers in 2014 for health purposes, 71 had publicly available terms and conditions:[4]\n57 of the 71 had disclaimer clauses (including 10 disclaiming liability for injury caused by their own negligence)\n51 let the company change terms (including 17 without notice)\n34 allow data disclosure in certain circumstances\n31 require consumers to indemnify the company\n20 promise not to sell data\nAmong 260 mass market consumer software license agreements in 2010:[5]\n91% disclaimed warranties of merchantability or fitness for purpose or said it was 'As is'\n92% disclaimed consequential, incidental, special or foreseeable damages\n69% did not warrant the software was free of defects or would work as described in the manual\n55% capped damages at the purchase price or less\n36% said they were not warranting whether it infringed others' intellectual property rights\n32% required arbitration or a specific court\n17% required the customer to pay legal bills of the maker (indemnification), but not vice versa\nAmong the terms and conditions of 31 cloud-computing services in January-July 2010, operating in England:[6]\n27 specified the law to be used (a US state or other country)\nmost specify that consumers can claim against the company only in a particular city in that jurisdiction, though often the company can claim against the consumer anywhere\nsome require claims to be brought within half a year to 2 years\n7 impose arbitration, all forbid illegal and objectionable conduct by the consumer\n13 can amend terms just by posting changes on their own website\na majority disclaim responsibility for confidentiality or backups\nmost promise to preserve data only briefly after terminating service\nfew promise to delete data thoroughly when the customer leaves\nsome monitor the customers' data to enforce their policies on use\nall disclaim warranties and almost all disclaim liability\n24 require the customer to indemnify them, a few indemnify the customer\na few give credits for poor service, 15 promise 'best efforts' and can suspend or stop at any time\nThe researchers note that rules on location and time limits may be unenforceable for consumers in many jurisdictions with consumer protections, that acceptable use policies are rarely enforced, that quick deletion is dangerous if a court later rules the termination wrongful, that local laws often require warranties (and UK forced Apple to say so).\nReadability[edit]\nAmong the 500 most-visited websites which use sign-in-wrap agreements in September 2018:[7]\n70% of agreements had average sentence lengths over 25 words, (where 25 or less is needed for consumer readability)\nmedian FRE (Flesch Reading Ease) score was 34 (where over 60 is considered readable by consumers)\nmedian F-K (Flesch-Kincaid) score was 15 years of school (498 of 500 had scores higher than the recommended 8th grade)\nAmong 260 mass market consumer software license agreements which existed in both 2003 and 2010:[5]\nmedian and mean Flesch scores were 33 in both years, with a range from 14 to 64 in 2003, and from 15 to 55 in 2010 (where over 60 is considered readable by consumers)\nmedian number of words rose from 1,152 to 1,354, with range of 33 to 8,406 in 2003, and from 106 to 13,416 in 2010\nPublic awareness[edit]\nA 2013 documentary called Terms and Conditions May Apply publicized issues in terms of services. It was reviewed by 54 professional critics[8] and won for Best Feature Documentary at the Newport Beach Film Festival 2013 and for Best Documentary at the Sonoma Valley Film Festival 2013.[9]\nClickwrapped.com rates 15 companies on their policies and practices with respect to using users' data, disclosing users' data, amending the terms, closing users' accounts, requiring arbitration, fining users, and clarity.\nTerms of Service; Didn't Read is a group effort that rates 67 companies' terms of service and privacy policies, though its site says the ratings are 'outdated.'[10] It also has browser add-ons that deliver the ratings while at the website of a rated company. Members of the group score each clause in each terms of service document, but 'the same clause can have different scores depending on the context of the services it applies to.'[11] The Services tab lists companies in no apparent order, with brief notes about significant clauses from each company. In particular, competitors are not listed together so that users can compare them. A link gives longer notes. It does not typically link to the exact wording from the company. The Topics tab lists topics (like 'Personal Data' or 'Guarantee'), with brief notes from some companies about aspects of the topic.\nTOSBack.org, supported by the Electronic Frontier Foundation, lists changes in terms and policies sequentially, 10 per page, for 160 pages, or nearly 1,600 changes, for 'many online services.'[12] There does not seem to be a way to find all changes for a particular company, or even which companies were tracked in any time period. It links to Terms of Service; Didn't Read, though that typically does not have any evaluation of the most recent changes listed at TOSBack.org.\nTerms of services are subject to change and vary from service to service, so several initiatives exist to increase public awareness by clarifying such differences in terms, including:\nAvailability of previous terms\nCancellation or termination of the account and/or service by user\nCopyright licensing on user content\nData tracking policy and opt-out availability\nIndemnification or compensation for claims against account or content\nNotification and feedback prior to changes in terms\nNotification of government or third-party requests for personal data\nNotification prior to information transfer in event of merger or acquisition\nPseudonym allowance\nReadability\nSaved or temporary first and third-party cookies\nTransparency of security practices\nTransparency on government or law enforcement requests for content removal\nCriticism and lawsuits[edit]\nAOL[edit]\nIn 1994, the Washington Times reported that America Online (AOL) was selling detailed personal information about its subscribers to direct marketers, without notifying or asking its subscribers. That article led to the revision of AOL's terms of service three years later.\nOn July 1, 1997, AOL posted their revised terms of service to take effect July 31, 1997, without formally notifying its users of the changes made, most notably a new policy which would grant third-party business partners, including a marketing firm, access to its members' telephone numbers. Several days before the changes were to take effect, an AOL member informed the media of the changes and the following news coverage incited a large influx of internet traffic on the AOL page which enabled users to opt out of having their names and numbers on marketing lists.[1]\nSony[edit]\nIn 2011, George Hotz and other members of failOverflow were sued by Sony Corporation. Sony claimed that Hotz and others had committed breach of contract by violating the terms of service of the PlayStation Network and the Digital Millennium Copyright Act.[13]\nInstagram[edit]\nSee also: Instagram § Criticism and lawsuits\nOn December 17, 2012, Instagram and Facebook announced a change to their terms of use that caused a widespread outcry from its user base. The controversial clause stated: 'you agree that a business or other entity may pay us to display your username, likeness, photos (along with any associated metadata), and/or actions you take, in connection with paid or sponsored content or promotions, without any compensation to you'.\nThere was no apparent option to opt out of the changed terms of use.[14] The move garnered severe criticism from privacy advocates as well as consumers. After one day, Instagram apologized, saying that it would remove the controversial language from its terms of use.[15] Kevin Systrom, a co-founder of Instagram, responded to the controversy, stating:\nOur intention in updating the terms was to communicate that we’d like to experiment with innovative advertising that feels appropriate on Instagram. Instead, it was interpreted by many that we were going to sell your photos to others without any compensation. This is not true and it is our mistake that this language is confusing. To be clear: it is not our intention to sell your photos. We are working on updated language in the terms to make sure this is clear.[16]\nZappos[edit]\nSome terms of services are worded to allow unilateral amendment, where one party can change the agreement at any time without the other party's consent. A 2012 court case In re Zappos.com, Inc., Customer Data Security Breach Litigation held that Zappos.com's terms of use, with one such clause, was unenforceable.[17]\n",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 16, // Adjust font size as needed
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
