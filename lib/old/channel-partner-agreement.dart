import 'package:financial_freedom/old/widgets/customer/customer-profile.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';

class ChannelPartnerDocument extends StatelessWidget {
  const ChannelPartnerDocument({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: backgroundColor(),
      ),
//       body: Html(
//         data: """
//         <body style="color: black">
// <div>
//     <div class="card highlight-card card-small">    
//         <span><b>CHANNEL PARTNER AGREEMENT</b></span>   
//     </div>
//       <br>
//       <span>
//       <p>
//         This Channel Partner Agreement 
//         <b>(the "Agreement")</b> 
//         is executed, on the date, when a person downloads the Mobile Application of the Referral Entity and register under the Category “User/ Channel Partner/ Financial Therapist”, at New Delhi:
//       </p>
//       <br>
//       <p class="center-text">
//           <b>
//             BY AND BETWEEN
//           </b>
//       </p>
//       <br>
//       <p>
//         <b>Insiderlab Fintech Private Limited</b>
//         , a company incorporated under the laws of India, having its registered office at 1603-1 Old RTO Road, South Civil Line Jabalpur Jabalpur MP 482001 IN (hereinafter referred to as the 
//         <b>"Referral Entity"</b>
//          or 
//          <b>“Company”</b>
//           which expression shall unless excluded by or repugnant to the subject or context be deemed to include its successors-in-interest and permitted assigns) of the 
//           <b>ONE PART</b>
//       </p>
//       <br>
//       <p class="center-text"><b>AND</b></p><br>
//       <p>
//     <b><span id="agentName"></span></b>, an individual or a proprietor, having its principal place of business at <b><span id="agentLocation"></span></b> 
//         (hereinafter referred to as the <b>"Channel Partner"</b> which expression shall unless excluded by or repugnant to the subject or context be deemed to include its successors-in-interest and permitted assigns) of the 
//             <b>OTHER PART</b>
//       </p>
//       <br>
//       <p class="font-italics">
//         (The Referral Entity/ Company and the Channel Partner shall hereinafter individually referred to as "Party" and collectively as "Parties")
//       </p>
//     </span>
//     <br>
//       <span>
//       <h4>
//         WHEREAS
//       </h4>
//       <p>
//         A. The Referral Entity <span class="font-italics">inter-alia</span> is engaged in the business of advertising, selling and marketing loan offers on its Mobile Application and other online platforms.
//       </p>
//       <p>
//         B. The Referral Entity has arrangements with Banks, Financial Institutions and other Direct Selling Agents, as the case may be, wherein the loan offers of these entities are advertised and marketed on the Mobile Application and other online platforms of the Referral Entity.
//       </p>
//       <p>
//         C. The Referral Entity desires to appoint Channel Partner for the purpose mentioned in <b>Schedule-A</b> of the Agreement. It is clarified that Channel Partner is solely engaged to provide the services to the Company/ Referral Entity solely by using its Mobile Application,
//       </p>
//       <p>
//         D. The Referral Entity, relying on the representation and warranties of the Channel Partner, has agreed to appoint Channel Partner on a non-exclusive basis for performing the service mentioned in <b>Schedule-A</b> on the terms and conditions as mentioned herein, on a principal to principal basis.
//       </p>
//       <p>
//         E. The Parties desire to enter into this Agreement to record their respective agreements as under.
//       </p>
//     </span>
//     <br>
//     <span>
//         <p>
//             NOW IN CONSIDERATION OF THE VARIOUS TERMS HEREIN CONTAINED, INCLUDING THE RECITALS WHICH FORM AN INTEGRAL AND BINDING PART OF THIS AGREEMENT, THE PARTIES AGREE AS FOLLOWS:
//         </p>
//         <br>
//         <h3>
//             1. DEFINITIONS AND INTERPRETATION            
//         </h3>
//         <p>
//             (a) <b>“Agreement”</b> shall mean this agreement between Company and Channel Partner  entered hereto and as amended from time to time and shall include all the Schedules to this Agreement;
//         </p>
//         <br>
//         <p>
//             (b) <b>"Applicable Law"</b> shall include all applicable (i) statutes, enactments, acts of legislature or parliament, laws, ordinances, rules, bye-laws, regulations, listing agreements, notifications, guidelines or policies of any jurisdiction; and (ii) judicial quasi-judicial and/or administrative decisions, interpretations, directions, directives, licenses, permits, judgments, writs, injunctions, arbitral awards, decrees, orders, terms and conditions of governmental or regulatory approvals or agreements with any governmental or regulatory authority;
//         </p><br>
//         <p>
//             (c) <b>"Approvals"</b> shall mean sanctions, permissions, consents, validations, confirmations, licenses, and other authorizations obtained and/or required to be obtained from any Government Body;
//         </p><br>
//         <p>
//             (c) <b>"Government Body"</b> means any government authority, statutory authority, government department, agency, commission, board, tribunal or court or other law, rule or regulation-making entity having or purporting to have jurisdiction on behalf of India or any state or other subdivision thereof or any municipality, district or other subdivision thereof;
//         </p><br>
//         <p>
//             (d) <b>"GST"</b> means Goods and services tax under the Goods and Services Tax Act, 2017;
//         </p><br>
//         <p>
//             (f) <b>"Term"</b> means the period during which this agreement shall be in force starting from the date of execution of this Agreement unless terminated as per the provision of this Agreement.
//         </p><br>
//         <p>
//             (g) <b>“Confidential Information”</b> means and includes all information of whatever nature used in or otherwise made available by Referral Entity and/ or  its Customer, including information which is disclosed in any tangible form, or all information concerning / provided by Referral Entity that is not known or generally available to the public at large, including without limitation, software and documentation, existing systems and computer software, future projects, business development or planning, commercial relationships and negotiations, the marketing of goods or services (including customer names and lists, sales targets, statistics,) financial statements and other financial information, employees lists, salaries and benefits and all other data sent by Referral Entity whether written, oral or on magnetic or other media exchanged to between the Parties, on or after the date hereof, is nevertheless disclosed as a result of the Parties' discussions and based on legends or other markings, the circumstances of disclosure or the nature of the information itself, should reasonably be understood by the Channel Partner as being proprietary and/ or confidential to Referral Entity;
//         </p><br>
//         <p>
//             (h) <b>"Intellectual Property Rights"</b> means all current and future copyright, patents, trademarks or rights in databases, inventions or trade secrets, know-how, rights in designs, topographies, trade and business names, domain names, marks and devices (whether or not registered) and all other intellectual property rights and applications for any of those rights (where such applications can be made) capable of protection in any relevant country of the world;
//         </p><br>
//         <p>
//             (i) <b>“Services”</b> means activities to be performed by Channel Partner as specifically provided in <b>Schedule – A</b>;
//         </p>
//         <br>
//         <p>
//             (j) <b>Interpretation:</b>
//         </p>
//         <ul>
//             <ol>
//                 (I) The headings in this Agreement are inserted for convenience only and shall be ignored in construing this Agreement.
//             </ol>
//             <br>
//             <ol>(II) Unless the context otherwise requires, in this Agreement:
//             </ol><br>
//             <ol>
//                 (III) words using the singular or plural number also include the plural or singular number, respectively;
//             </ol><br>
//             <ol>
//                 (IV) words denoting any gender shall include all genders;
//             </ol><br>
//             <ol>
//                 (V) the words "written" and "in writing" include any means of visible reproduction;
//             </ol><br>
//             <ol>
//                 (VI) the terms "hereof", "herein", "hereto" and similar words refer to this entire Agreement and not any particular Clause, or any other subdivision of this Agreement;
//             </ol><br>
//             <ol>
//                 (VII) the words "include" or "including" shall be deemed to be followed by "without limitation" or "but not limited to" whether or not they are followed by such phrases or words of like import;
//             </ol><br>
//             <ol>
//                 (VIII) references to any "person" include any natural person, corporation, judicial entity, association, statutory body, partnership, limited liability company, joint venture, trust, estate, unincorporated organisation or government, state or any political subdivision, instrumentality, agency or authority; and
//             </ol><br>
//             <ol>
//                 (IX) references to "Clause" or any other agreement or document in this Agreement shall be construed as references to the Clauses of this Agreement, or such other agreement or document, as may be amended, modified or supplemented from time to time, and shall include a reference to any document which amends, modifies or supplements it, or is entered into, made or given pursuant to or in accordance with its terms.
//             </ol>
//         </ul>        
//     </span>
//     <br>
//     <span>
//         <h3>2. SERVICES & SERVICE CHARGE</h3>
//         <p>(a) Service Charges are more specifically mentioned in <b>Schedule-B</b> along with the conditions.</p><br>
//         <p>
//             (b) Subject to the terms of this Agreement during the Term:
//         </p>
//         <ul>
//            <ol>I. The Referral Entity agree to engage Channel Partner for providing the Services as defined in this Agreement and described in detail in <b>Schedule–B</b> or as amended by the Referral Entity from time to time through intimation to the Referral Entity;</ol><br>
//            <ol>II. Channel Partner agrees to cooperate with Referral Entity and provide information required for making this arrangement successfully;</ol><br>
//            <ol>III. The Parties hereto have agreed that this Agreement shall be on the basis of a contract whereby the Referral Entity has indicated the required Services and the Channel Partner has agreed to provide the Services to the Referral Entity by itself and without any assistance and/or supervision by the Referral Entity, unless otherwise agreed between the Parties, as a composite and complete service.</ol>
//         </ul>
//         <p>
//             (c) The Channel Partner shall:
//         </p>
//         <ul>
//             <ol>(I) Provide the Services in compliance with this Agreement, Terms of Use and Privacy Policy of the Company, and Applicable Laws. If any Approvals are to be obtained for the provision of Services the same shall be obtained by the Channel Partner;</ol><br>
//             <ol>(II) Perform the Services (i) in a professional, diligent and timely manner; and (ii) as per good commercial practices;</ol><br>
//             <ol>(III) Retain and utilize a sufficient number of qualified personnel to perform the Services;</ol><br>
//             <ol>(IV) Ensure that all personnel who are deputed to perform the Services are appropriately trained and qualified to perform such Services; and</ol><br>
//             <ol>(V) Devote its time and attention necessary to provide the Services in accordance with the best of the industry standards and meet any quality standards as may be specified by the Referral Entity.</ol><br>
//         </ul>
//         <br>
//         <p>
//             (d) Unless otherwise authorized in writing, the Channel Partner shall not have any authority pursuant to this Agreement to commit the Referral Entity to any obligation in any manner whatsoever with respect to third parties or to enter into any contracts on behalf of the Referral Entity except for the purpose of this agreement. The Channel Partner shall not have, nor represent itself as having, any authority under the terms of this Agreement to make agreements of any kind in the name of or binding upon the Client.
//         </p><br>
//         <p>
//             (e) The Channel Partner shall keep the Referral Entity promptly informed of all material matters which come to Channel Partner's attention relating to or affecting the business of the Referral Entity or any matters concerning the provision of Services hereunder by the Channel Partner.
//         </p><br>
//         <p>
//             (f) The Channel Partner agrees and acknowledges that if it approaches a customer on the basis of the loan offers/ data/ other information available on the Mobile Application/ other electronic platform of the Referral Entity, and in case the customer agree to avail any of such loan offers, then the Channel Partner undertakes that such customer shall be processed though the Referral Entity only and no one else.
//         </p><br>
//         <p>
//             (g) The Services to the Company shall be deemed to be provided at New Delhi.
//         </p>
//     </span>
//     <br>
//     <span>
//         <h3>
//             3. TERM
//         </h3>
//         <p>
//             The term of this Agreement will be for 3 years (Three years) (“Term”) from the Commencement Date ("Term") unless earlier terminated according to the terms of this Agreement.
//         </p>
//     </span>
//     <br>
//     <span>
//         <h3>4. RENEWAL</h3>
//         <p>
//             The Company shall have the option to renew this agreement on such terms and conditions as the Company may decide.
//         </p>
//     </span>
//     <br>
//     <span>
//         <h3>5. CONFIDENTIALITY AND NON-DISCLOSURE</h3>
//         <p>
//             The Channel Partner recognizes, accepts and agrees that the Confidential Information provided or disclosed by the Referral Entity or obtained by the Channel Partner  and/or its employees, including Referral Entity's practices and trade secrets, customer data, which may be communicated to the Channel Partner and/or its employees may be privy under or pursuant to this Agreement and / or in the course of performance of the Services under this Agreement shall be treated as absolutely confidential and the Channel Partner hereby irrevocably agrees and undertakes and ensures that the Channel Partner and all its employees shall keep the same as secret and confidential and shall not disclose the same, at all in whole or in part to any person or persons (including legal entities) at any time or use nor shall allow the Confidential Information to be used for any purpose other than as may be necessary for the due performance of Services. The Channel Partner hereby specifically agrees to indemnify and keep Referral Entity and their respective employees fully indemnified safe and harmless at all times against all/any consequences arising from any breach of this undertaking by the Channel Partner and/or its employees and shall immediately reimburse/pay to Referral Entity on demand all damages, loss, cost, expenses or any charges that Channel Partner may be required to suffer, pay or incur in connection therewith.
//         </p>
//     </span>
//     <br>
//     <span>
//         <h3>6. REPORTS</h3>
//         <p>The Channel Partner shall from time to time provide information and reports in relation to the performance of the Services as may be requested by the Referral Entity.
//         </p>
//     </span>
//     <br>
//     <span>
//         <h3>7. REPRESENTATIONS AND WARRANTIES</h3>
//         <p>
//             (a) Each Party hereby warrants and represents to the other Party that:
//         </p>        
//         <ul>
//             <ol>(I) It has full power and authority to enter into this Agreement and perform its obligations hereunder;</ol><br>
//             <ol>(II) This Agreement has been duly executed by it and this Agreement constitutes its legal, valid and binding obligation enforceable in accordance with the terms contained herein;</ol><br>
//             <ol>(III) The execution, delivery and the performance by it of this Agreement does not and will not (i) breach or constitute a default under its constitutive documents, or (ii) result in a breach of, or constitute a default under, any agreement to which it is a party or by which it is bound.</ol>
//         </ul>
//         <br>
//         <p>
//             (b) The Channel Partner hereby represents and warrants to the Referral Entity:
//         </p>
//         <ul>
//             <ol>(I) It will provide the Services in compliance with the provisions of this Agreement;</ol><br>
//             <ol>(II) It will act in good faith and use reasonable skill and care in the provision of Services under this Agreement;</ol><br>
//             <ol>(III) It will comply with all Applicable Laws in the provision of the Services;</ol><br>
//             <ol>(IV) It has all requisite corporate and other approvals, licenses and permits from relevant governmental authorities to provide the Services.</ol><br>
//             <ol>(V) It has full capacity, power, and authority to carry out and perform the Services and has already taken and will continue to take all necessary and further actions.</ol><br>
//             <ol>(VI) It has the necessary skills, knowledge, experience, expertise, required capital net worth, adequate and competent facility, Staff, systems, equipment and procedures and capability to duly perform the Services in accordance with the terms of this Agreement and to the satisfaction of Referral Entity, provided however that Referral Entity’s judgement as regards the quality and skills of the Channel Partner and its employees, shall be final and binding on the Channel Partner.</ol><br>
//             <ol>(VII) The Channel Partner hereby acknowledges and accepts that Referral Entity has relied upon the above representations and warranties and has entered into this Agreement.</ol>
//         </ul>
//     </span>
//     <br>
//     <span>
//         <h3>8. THE CHANNEL PARTNERS’S COVENANTS</h3><br>
//         <p>The Channel Partner hereby agrees, undertakes and confirms as under:-</p>
//         <ul>
//             <ol>(a) The Channel Partner shall, at all times, maintain and respect, and shall also procure its employees to maintain and respect, the confidentiality of all/any matters relating to the Services, the Confidential Information, and this Agreement, unless required under Applicable Law. If the Confidential Information is required to be furnished to any authorities under Applicable Law, the Channel Partner shall give prior intimation to Referral Entity before providing such Confidential Information.</ol><br>
//             <ol>(b) Without prior written permission of Referral Entity, the Channel Partner and its employees shall not at any time use the name and/or trademark/logo of Referral Entity in any manner and for any purpose whatsoever.</ol><br>
//             <ol>(c) The Services to be rendered pursuant to this Agreement shall be rendered and performed by the Channel Partner, and it shall cause its employees to render and perform the same, with utmost care and diligence and shall be of the highest quality and standards. If at any time Referral Entity is dissatisfied with the Services rendered by the Channel Partner, Referral Entity shall be entitled to terminate this Agreement with immediate effect without providing any notice to the Channel Partner. Company’s decision in this regard shall be final, absolute and binding on the Channel Partner;</ol><br>
//             <ol>(d) The Confidential Information handed over by Referral Entity to the Channel Partner and/or its employees in terms of this Agreement or which comes into the hands of the Channel Partner and/or its employees’ custody, power or possession pursuant to or in connection with this Agreement will remain the sole and absolute property of Referral Entity, and the Channel Partner and /or its employees shall not have and also shall not claim any charge, claim, lien, right of retention, sale or set-off or other right, title or interest therein or thereon for any reason whatsoever. The Channel Partner and/or its employees, shall not at any time use or attempt to use Referral Entity’s logo/trademark or letterheads for any purpose whatsoever including for any purposes to perform the Services in terms of this Agreement.</ol><br>
//             <ol>(e) Referral Entity shall be entitled to access all books, records and information relevant to the Services available with the Channel Partner. Upon request from Referral Entity, the Channel Partner shall within 2 (two) days of such request provide to Company access to all the books, records and information in connection with Services available with the Channel Partner.</ol><br>
//             <ol>(f) Company shall have a right to monitor and assess the Services to be provided by the Channel Partner under this Agreement and suggest corrective measures, if any, required to can be taken by the Channel Partner.</ol><br>
//             <ol>(g) The Channel Partner shall not without prior approval/consent of Company, use any sub-contractor for undertaking all or part of the Services.</ol><br>
//             <ol>(h) Company and its authorized representatives shall have a right to periodically conduct audits on the Channel Partner whether by its internal or external auditors, or by agents appointed to act on its behalf and to obtain copies of any audit or review reports and findings made on the Channel Partner in conjunction with the services performed for the Referral Entity.</ol><br>
//             <ol>(i) The Channel Partner shall preserve all the documents and data pertaining to the Services under this Agreement for a period of 4 years.</ol><br>
//             <ol>(j) The Channel Partner shall provide access to customer information of Company to the employees on ‘need to know’ basis i.e., limited to those areas where the information is required in order to perform the Services.</ol><br>
//             <ol>(k) The Channel Partner shall isolate and clearly identify the Company’s customer information, documents, records and assets to protect the confidentiality of the information. In instances, where Channel Partner acts for multiple banks, non-banking financing services and financial institutions, care shall be taken by it to build strong safeguards so that there is no comingling of information/documents, records and assets.</ol><br>
//             <ol>(l) The Channel Partner shall provide Services in compliance with the Applicable laws (including but not limited to Information Technology Act, 2000 and rules made there under, as amended, modified or substituted from time to time). The Channel Partner represents and warrants that it has all the necessary legitimate rights, licenses and/or authorization as regards software, tools, techniques, used to it relating to the Services rendered under this agreement and for providing the Services and safeguarding the Confidential Information.</ol><br>
//             <ol>(m) Ensure that the personnel employed by the Channel Partner shall at all times conduct themselves within the parameters of all applicable laws and shall not commit or permit the commission of any offence; and in the event of any offence being committed, the Channel Partner and the person committing the offence shall be liable for all consequences thereof and the Company shall not be directly or vicariously liable.</ol><br>
//             <ol>(n) Ensure compliance with the provisions of this agreement or instructions issued by the Company from time to time.</ol><br>
//             <ol>(o) Immediately notify the Company in writing if any of its personnel or any other person engaged by the Channel Partner has committed any act amounting to moral turpitude or has been arrested by the police or removed from the employment of the Channel Partner or committed any act affecting the integrity of the person.</ol><br>
//             <ol>(p) Ensure courteous service and maintain the service standards as prescribed by the Company from time to time.</ol><br>
//             <ol>(q) Obtain all licenses / permissions / authorizations as required under all the applicable laws and keep the same valid by renewing it from time to time as required under the said Acts. In case of contravention, the Company will not be liable for any act arising out of the said contravention.</ol><br>
//             <ol>(r) Maintain all the registers and records required to be maintained under the various laws and enactments.</ol><br>
//             <ol>(s) Use only such letter head, invoices, signs, displays materials, promotional literature, equipment and other items in connection with the Services as shall be approved in writing by the Company and to immediately desist from the use of display of any signs, material or objects if the Company directs.</ol><br>
//             <ol>(t) Provide the Services during the term of this agreement on such days and between such hours, as the Company shall specify.</ol><br>
//             <ol>(u) Permit the Company and its representatives to enter the premises as and when required for the purposes of ascertaining whether the provisions of this agreement are being complied with.</ol><br>
//             <ol>(v) The Channel Partner shall be liable for any and all losses / damages arising directly or indirectly from any dishonest, criminal or fraudulent act of any of the personnel engaged or employed by the Channel Partner.</ol><br>
//             <ol>(w) (a) During the performance of the Services the Channel Partner will co-operate with the Referral Entity as the Referral Entity reasonably requires;</ol>
//         </ul>
//     </span>
//     <br>
//     <span>
//         <h3>9. RESTRICTION ON THE CHANNEL PARTNER</h3>
//         <p>Unless otherwise agreed to by the Company, the Channel Partner shall:</p>
//         <ul>
//             <ol>
//                 a) Not to use the name or corporate logo of the Company or any part thereof except as authorized by the Company in writing.</ol><br>
// <ol>(b) Not do or omit to do any act or thing which may in the sole opinion of the Company bring the name of the Company or the corporate logo of the Company into disrepute or which, may in the sole opinion of the Company damage or conflict with the interests of the Company.</ol><br>
// <ol>(c) Not to use or publish any advertisements, signs, directory entries or other forms of publicity whether or not relating in whole or in part to the Service or display the same on or at the premises unless the same shall have been submitted to and approved by the Company.</ol><br>
// <ol>(d) Not to work in a manner which in the opinion of the Company may be detrimental to the interest of the Company and which may affect the Service.</ol><br>
// <ol>(e) Not to receive money in any form either by way of commission or brokerage from any customer or borrower of the Company or from any third party for sourcing business or allow his judgment to be based on any extraneous thing other than the qualitative facts.</ol><br>
// <ol>(f) That Channel Partner shall not represent itself as an Agent or an employee or partner of the Company or permit itself to be so represented by any other person or persons in any form whatsoever. The Channel Partner is engaged to provide the services to the Company only through its Mobile Application.</ol><br>
//         </ul>
//     </span>
//     <br>
//     <span>
//         <h3>10. ADVERTISING</h3>
//         <ul>
//             <ol>a) The Channel Partner can undertake with the consent of the Company the responsibility of advertising for the purpose of this agreement.</ol><br>
//             <ol>b) The Company may make available to the Channel Partner advertising materials including posters, leaflets, displays, flyers, stickers, signs, cards and notices and the Channel Partner shall at its own expense prominently display, maintain and distribute the same as the case may be. However, if any additional advertising material is required by the Channel Partner, the Company shall supply the same at the cost price.</ol><br> 
//                 <ol>c) The Channel Partner shall co – operate with the Company and the other direct sale associates of the Company in any special advertising or sales promotion or other special activity and will engage in other promotional activities as the Company may direct.</ol><br>                 
//                 <ol>d) In case of any advertising campaign conducted by the Channel Partner and the Company jointly all expenses shall be shared as may be mutually agreed between the parties.</ol>
//         </ul>
//     </span>
//     <br>
//     <span>
//         <h3>11. ACCOUNTS AND RECORDS</h3>
//         <ul>
//             <ol>a) The Channel Partner shall maintain accurate accounts and records, statements of all its operations and expenses under this agreement and submit a statement / report in the manner specified by the Company.</ol><br>
//                 <ol>b) In no event the Company shall be liable for any indirect, special or consequential damages which may arise under this agreement.</ol><br>
//                 <ol>c) The Channel Partner shall furnish to the Company a half yearly profit and loss account of the Service under this Agreement within 15 days of finalization of the same.</ol>                
//         </ul>
//     </span>
//     <br>
//     <span>
//         <h3>12. ETHICS AND CODE OF CONDUCT</h3>
//         <p>
//             Channel Partner declare and undertake to the Company the following:
//         </p>
//         <ul>
//             <ol>(a) That it (including its employees and business associates) will conduct all its dealings in a very ethical manner and with the highest business standards.</ol><br>
// <ol>(b) That it (including its employees and business associates) will provide all possible assistance to the Company in order to investigate any possible instances of unethical behavior or business conduct violations by an employee.</ol><br>
// <ol>(c) That it (including its employees and business associates) will disclose forthwith any breach of these provisions that comes to their knowledge to allow for timely action in their prevention and detection.</ol><br>
// <ol>(d) That it (including its employees and business associates) will comply with, and all its activities will be performed in accordance with, the Anti-Corruption Laws and that it shall not do, nor omit to do, any act that will lead to other Party being in breach of any of the Anti-Corruption Laws.</ol><br>
// <ol>(e) That it (including its employees and business associates) has not and it (including its employees and business associates) will not make (or offer to make) any unlawful payments to, or confer (or offer to confer) any benefit upon any government official, any officer or employee of a public organization, any political party or official thereof or any candidate for political office on or behalf of the Company or any of its affiliates in violation of any applicable anti-bribery laws or regulations, and the Company will not bear any responsibility for such acts.</ol>            
//         </ul>
//     </span>
//     <br>
//     <span>
//         <h3>13. INDEMNITY</h3>
//         <p>
//             (1)  The Channel Partner hereby agree to fully indemnify, hold harmless and defend the Company their respective officers, directors, personnel, representatives, consultants, nominees, designees from and against all claims, demands, actions, suits, damages, liabilities, losses, settlements, judgments, costs and expenses (including but not limited to reasonable attorney’s fees and costs), or any other loss that may occur (directly or indirectly), whether or not involving a third party claim, which arise out of or relate to:
//         </p>
//         <ul>
//             <ol>(a) Breach of any representation or warranty contained in this Agreement;</ol><br>
//             <ol>(b) Acts, commissions, omissions, errors, fraudulent act, misfeasance, representations, misrepresentations, misconduct, negligence of the Channel Partner and/or its Personnel in performance of its obligations under this Agreement.;</ol><br>
//             <ol>(c) Any breach of any of the provisions of this Agreement, including but not limited to the obligations pertaining to confidentiality and intellectual property by the Channel Partner or its Personnel;</ol>
//         </ul>
//         <br>
//         <p>(2)  The Channel Partner shall not set up defence or claim in any suit, plaint, petition, complaint, written statement, application to the effect that the Personnel of the Channel Partner are the employees of the Company and in the event any such defence is set up the same shall be a fraud upon the court or authority where such defence or claim is set up and in this regard, the Channel Partner further agrees to indemnify and keep the Company indemnified, at all times.</p><br>
//         <p>(3)  The Company shall have no liability whatsoever for any injury to the Channel Partner and/or its Personnel caused or suffered in the course of performance of the Channel Partner’s obligations hereunder and in this regard, the Channel Partner further agrees to indemnify and keep the Company indemnified at, all times.</p><br>
//         <p>(4)  The Channel Partner specifically agrees that for any act of the Channel Partner, no claim shall lie against the Company from any third party and the Company shall not be held liable in any circumstances for the acts of the Channel Partner. All claims of third parties shall be defended by the Channel Partner and in this regard the Company shall be kept indemnified against all claims, losses, damages, charges etc.</p><br>
//         <p>(5)  Notwithstanding anything contained in this Agreement or any other documents executed or to be executed between the Parties, all indemnities shall survive expiry or termination of this Agreement and the Channel Partner shall continue to be liable under the indemnities for a period not less than 8 (eight) years from the expiry/termination of this Agreement.</p>
//     </span>
//     <br>
//     <span>
//         <h3>14. INDEPENDENT CONTRACTORS</h3>
//         <p>The Parties herein are independent contractors. Neither Party hereto, nor any of its respective agents, shall be construed to be the agent or representative of the other.</p>
//     </span>
//     <br>
//     <span>
//         <h3>15. TERMINATION</h3>
//         <p>
//             Without prejudice to any other remedies available under this Agreement or under the common law, the Company may terminate this agreement by giving 30 days written notice to the Channel Partner.
//         </p>
//         <p>
//             This agreement shall be valid for a period as indicated above and can be renewed for further period as mutually agreed upon by the parties. Provided however the Company shall in its sole discretion be at liberty to terminate the agreement at any time without notice and / or without assigning any reason. Upon such termination, the Company shall be at liberty to advertise the termination in such manner and form as it may deem fit. Upon termination / expiry, Channel Partner shall return all forms, brochures and other stationary and printed material of the Company lying with it to the Company.
//         </p>
//     </span>
//     <br>
//     <span>
//         <h3>16. EVENTS OF TERMINATION</h3>
//         <p>On the occurrence of any of the events specified below, the Company shall be entitled (without prejudice to any other right or remedies which the Company may have under these presents or otherwise in law), to terminate this agreement as provide in this agreement at any time after the occurrence of such event.</p>
//         <ul>
//             <ol>(a) If the Channel Partner fails or neglects to observe or commits or allows to be committed any breach of the terms, conditions, provisions or stipulations of this agreement on its part to be performed and if such breach is remediable, fails to remedy such breach required to be remedied.</ol><br>
//             <ol>(b) If any of the representations or warranties made by the Channel Partner are found to be false of wrong.</ol><br> 
//             <ol>(c) If the Channel Partner does or suffers any act or thing or omits to do or suffers to be done any act, thing, deed or matter whereof in the consequence of which the business of the Company may be or is likely to suffer.</ol><br>
//             <ol>(d) If the Channel Partner by its act or omission gives to the Company reasonable ground to consider that its rights under this agreement may be prejudiced or jeopardized</ol><br>
//             <ol>(e) In case the Company is fixing target for the business and the Channel Partner fails to achieve the targets set out by the Company for the duration stipulated.</ol><br> 
//             <ol>(f) If at any time it is found that the Channel Partner is acting either directly or indirectly as a Channel Partner, associate or representative of any other entity engaged in similar line of business.</ol>
//         </ul>
//     </span>
//     <br>
//     <span>
//         <h3>17. CONSEQUENCES OF TERMINATION</h3>
//         <p>
//             (1) Upon the termination or expiration of this agreement for any reason, the Channel Partner shall:
//         </p>
//         <ul>
//             <ol>(a) Immediately cease to operate as the Channel Partner and not to thereafter hold itself out in any way as the Channel Partner of the Company and refrain from any action that would or may indicate any relationship between it and the Company.</ol><br>
//             <ol>(b) Immediately cease to use in any manner whatsoever name of the Company and the corporate logo of the Company.</ol><br>
//             <ol>(c) Return to the Company forthwith or otherwise dispose of or destroy as the Company shall direct all signs, advertising materials, stationery, invoices, forms, specifications, designs, records, data, samples. Models, programs and drawings pertaining to or concerning the Services or the procedures or bearing any of the corporate logo of the Company.</ol><br>
//             <ol>(d) Remove forthwith or permanently cover all signs or advertisements identifiable in any way with the Company and in event of failure to do so promptly, to permit the authorized associates of the Company to enter the Premises for such purpose.</ol><br>
//             <ol>(e) Do all such acts and things and execute all such documents as the Company shall require, in particular but without limitation such notification of cessation of this agreement.</ol><br>
//             <ol>(f) The expiration or termination of this agreement shall be without prejudice to the accrued rights of the parties and any provision hereof and shall remain in full force and effect and shall be enforceable notwithstanding such expiry or termination.</ol>
//         </ul>        
//         <p>(2) Notwithstanding anything to the contrary, provisions in respect of Dispute Resolution, Indemnity, Limitation of Liability and the other provisions of this Agreement which are expressly or impliedly intended to survive the expiration or termination of this Agreement, shall survive the expiration of the Term or any termination of this Agreement.</p>
//     </span>
//     <br>
//     <span>
//         <h3>18. INTELLECTUAL PROPERTY & DATA</h3>
//         <ul>
//             <ol>a. Subject to the terms of this Agreement, during the Term, both Parties reserve the right to permit other Party (with a right to withdraw the permission) to use certain Intellectual Property Rights for the purpose of this Agreement.</ol><br> 
//             <ol>b. Any such use permission and the terms thereof shall be in writing shall not be treated as an assignment of any rights on the same.</ol><br>
//             <ol>c. All such permissions shall stand withdrawn upon termination of this Agreement.</ol><br>
//             <ol>d. Referral Entity shall retain all right, title and interest in and to its intellectual property and no right, title or interest therein is transferred or granted to Channel Partner under this Agreement except for use in performing Services hereunder and for no other purpose. Referral Entity shall retain all right, title and interest in and to its own technology and information and, except as expressly set forth in this Agreement, no right, title or interest therein is transferred or granted to Channel Partner under this Agreement</ol><br>
//             <ol>e. In connection with the provision of the Services, the Channel Partner may generate, create, write or produce literary works or other works of authorship including, but not limited to, manuals, training materials, reports, advice, methodologies, code, test data, analyses, studies, research and documentation (hereinafter referred to as "Work Product").</ol><br>                 
//             <ol>f. The Work Product and copyright and all Intellectual Property rights in and to such Work Product created by the Channel Partner shall be owned by the Channel Partner exclusively.</ol><br>                 
//             <ol>g. Any data collected by the Channel Partner during the performance of the services shall be the property of the Referral Entity. Channel Partner will not dispute the rights of the Referral Entity, in any manner whatsoever, over any such data. Referral Entity shall be entitled to utilise the said data for their promotion and business goals in accordance with law.</ol>
//         </ul>
//     </span>
//     <br>
//     <span>
//         <h3>19. SET OFF</h3>
//         <p>The Company shall have a paramount charge, lien and right of set off on all monies payable, to the Channel Partner or standing to the credit of the Channel Partner with the Company or any of Company’s Affiliates against all or any sums which the Channel Partner is liable to pay under the Agreement or in respect of any other arrangement entered into by the Channel Partner with the Company or its Affiliates. In the event that there remains any amount due from the Channel Partner either to the Company or any of its Affiliates under the Agreement or otherwise, the monies payable to the Channel Partner or standing to the credit of the Channel Partner shall be applied first towards the outstanding amount owed by the Channel Partner to the Company or its Affiliates under the Agreement or any other agreement / facilities and the Channel Partner consents, confirms and agrees to execute any documents/ writings, as may be required, in this regard.</p>
//     </span>
//     <br>
//     <span>
//         <h3>20. SUB-CONTRACTORS</h3>
//         <p>
//             For the avoidance of any doubt, the Parties hereby agree that in connection with the performance of the Services, the Channel Partner may avail the services of such third parties and subcontractors as it considers appropriate. However, the Channel Partner shall continue to be fully responsible for the due performance of the Services agreed to be performed under this Agreement.<br>
// The Channel Partner shall be solely responsible for any payments to be made to the Channel Partner’s employees, agents or subcontractors in relation to the provision of Services under this Agreement, including without limitation any payments for salary, benefits or any other amounts due to such employees, agents or subcontractors in relation to the provision of Services under this Agreement.
//         </p>
//     </span>
//     <br>
//     <span>
// <h3>21. FORCE MAJEURE</h3>
// <p>
//     If and to the extent that a Party's performance of any of its obligations under this Agreement, hindered or delayed by fire, flood, earthquake, elements of nature or acts of God, acts of war, terrorism, riots, civil disorders, rebellions or revolutions, or any other similar cause beyond the reasonable control of such Party (each, a "Force Majeure Event"), and such non-performance, hindrance or delay could not have been prevented by reasonable precautions, then the non-performing, hindered or delayed Party will be excused for such non-performance, hindrance or delay, as applicable, of those obligations effected by the Force Majeure Event for as long as such Force Majeure Event continues and such Party continues to use its best efforts to recommence performance whenever and to whatever extent possible without delay, including through the use of alternate sources, workaround plans or other means. The Party whose performance is prevented, hindered or delayed by a Force Majeure Event will immediately notify the other Parties of the occurrence of the Force Majeure Event and describe in reasonable detail the nature of the Force Majeure Event.<br>
// If the Force Majeure Event continues for a continuous period exceeding 30 (thirty) days, the Parties shall mutually agree on the future course of action. However, despite all efforts made by the Parties in good faith, if the Force Majeure Event continues for a period of 90 (ninety) days, either of the Parties shall have the right to terminate this Agreement by giving the other

// </p>
//     </span>
//     <br>
//     <span>
//         <h3>22. LIMITATION OF LIABILITY</h3>
//         <p>The Company will not be liable for any punitive or consequential or indirect losses or damages, including lost profits or third party claims arising out of or relating to its performance or failure to perform under this Agreement. Liability of the Company for all punitive or consequential or indirect losses or damages is hereby expressly excluded.<br>
//             Notwithstanding anything contained in this Agreement, the Company’s liability for any loss or damage, direct or indirect, for any cause whatsoever (including, but not limited to, those arising out of or related to this Agreement) with respect to claims (whether third party claims, indemnity claims or otherwise) shall not under any circumstances exceed Rs. 50,000/- (Rupees Fifty Thousand Only).<br>
//             The Company shall not have any liability whatsoever in case of any third party claims, demands, suit, actions, or other proceedings against the Channel Partner or its Personnel in the course of performance of the its obligations under the Agreement;
//         </p>
//     </span>
// <br>
// <span>
//     <h3>23. TAXES</h3>
//     <p>Channel Provider shall be responsible for all taxes in respect of this Agreement including without limitation payment of goods and services tax, if applicable, on the Services provided hereunder. The Company shall be making the payment to the Channel Partners after making the necessary tax deductions including GST in accordance with law.</p>
// </span>
// <br>
// <span>
//     <h3>24. SEVERABILITY</h3>
//     <p>If any provision of this Channel Partner Agreement shall for any reason be held to be invalid, illegal, or unenforceable in any respect, such invalidity, illegality, or unenforceability shall not affect any other provision thereof, and this Channel Partner Agreement shall be construed as if such invalid, illegal or unenforceable provision had never been contained herein. Any invalid or unenforceable provision of this Channel Partner Agreement shall be replaced with a provision that is valid and enforceable and most nearly gives effect to the original intent of the invalid/unenforceable provision.</p>
// </span>
// <br>
// <span>
//     <h3>25. ENTIRE AGREEMENT</h3>
//     <p>This Channel Partner Agreement constitutes the entire agreement and understanding of the Parties with respect to the subject matter hereof and supersedes any and all prior negotiations, correspondence, agreements, understandings duties or obligations between the Parties with respect to the subject matter hereof.</p>
// </span>
// <br>
// <span>
//     <h3>26. PRIVACY & OTHER POLICIES</h3>
//     <p>The Channel Partner is also bound by the “Privacy Policy” and “Terms of Use for Channel Partner” of the Company, as amended from time to time.</p>
// </span>
// <br>
// <span>
//     <h3>27. NO OTHER RIGHTS GRANTED</h3>
//     <p>Nothing in this Agreement is intended to grant any rights under any patent, copyright or other intellectual property rights/ or any rights of any Party in favour of the other, nor shall this Agreement be construed to grant any Party any rights in or to the other Party's Confidential Information, except the limited right to use such Confidential Information in connection with the Services to be provided under this Agreement. The Channel Partner shall not receive any intellectual property rights in the Confidential Information of the other Party other than a limited right to use the Confidential Information for the purposes specified in this Agreement. All intellectual property rights shall continue to vest with the Party disclosing the Confidential Information.</p>
// </span>
// <br>
// <span>
//     <h3>28. AMENDMENTS</h3>
//     <p>Any change, alteration, amendment, or modification to this Channel Partner Agreement must be in writing and signed by authorized representatives of both the Parties.</p>
// </span>
// <br>
// <span>
//     <h3>29. DISPUTE RESOLUTION</h3>
//     <ul>
//         <ol>(a) Any dispute(s) arising out of this Agreement shall, as far as possible, be settled amicably between the Parties hereto failing which the following shall apply:</ol><br>
//         <ol>(b) Any dispute under this Agreement shall be referred to arbitration by a sole arbitrator named Adv Syed Mohd Shoeb, Enrol. No. D/3966/2012, C-57, Lower Ground Floor, Defence Colony, Delhi-110024</ol><br>
//         <ol>(c) The arbitration proceedings shall be held in Delhi in accordance with the provisions of the Arbitration and Conciliation Act, 1996 or any statutory re-enactment or modification thereof for the time being in force.</ol><br>
//         <ol>(d) The Parties agree that the arbitration award shall be final and may be enforced as a decree.</ol><br>
//         <ol>(e) The Parties further agree that subject to the above only the competent courts at Delhi shall have jurisdiction in all matters arising hereunder.</ol><br>
//         <ol>(f) The Parties further agree to keep the arbitration proceedings and the arbitral award confidential.</ol><br>
//         <ol>(g) If either Party employs attorneys to enforce any rights arising out of or relating to this Agreement, the prevailing Party shall be entitled to recover reasonable costs and attorneys' fees.</ol><br>
//     </ul>
// </span>
// <br>
// <span>
//     <h3>30. INDEPENDENT PARTIES</h3>
//     <p>Nothing contained or implied in this letter creates a joint venture or partnership between the Parties or makes one party the agent or legal representative of the other party for any purpose.</p>
// </span>
// <br>
// <span>
//     <h3>31. EXCLUSIVITY</h3>
//     <p>
//         Nothing in this Agreement restricts a Party or its group companies from discussing similar arrangements and/or any related transaction with any other party, any regulatory body in India and their respective successors.
//     </p>
// </span>
// <br>
// <span>
//     <h3>32. ASSIGNMENT</h3>
//     <p>
//         This Agreement shall not be assignable by any Party without prior written consent of the other Party.
//     </p>
// </span>
// <br>
// <span>
//     <h3>33. ANNOUNCEMENTS</h3>
//     <p>A Party shall not make any news releases, public announcements, give interviews, issue or publish advertisements or publicize in any other manner whatsoever in connection with this Agreement, the contents/provisions thereof, other information relating to this Agreement, the Confidential Information or other matter of this Agreement, without the prior written approval of the other Party.</p>
// </span>
// <br>
// <span>
//     <h3>34. NOTICES</h3>
//     <p>
//         Except as otherwise specified in this Agreement, all notices, requests, consents, approvals, agreements, authorizations, acknowledgements, waivers and other communications required or permitted under this Agreement shall be in writing and shall be deemed given when sent to the address specified below.<br>
//         In the case of Referral Entity:<br>
//         Attention: Harpreet Singh & Karan Babbar, Co-Founders - InsiderLab Fintech Pvt Ltd.<br>
//         Email: <a href="mailto://admin@insiderlab.in">admin@insiderlab.in</a><br>
//         Address : 1603/1 Old RTO Road, South Civil Lines, Jabalpur, M.P., 482001<br>
//         In case of Channel Partner- on the email address, which is used to register on the Mobile Application of the Referral Entity<br>
//         Either Party may change its address for notification purposes by giving the other Party 10 (ten) days’ notice of the new address and the date upon which it will become effective.
//     </p>
// </span>
// <br>
// <span>
//     <h3>35. GOVERNING LAW</h3>
//     <p>This Agreement and all issues arising out of the same shall be construed in accordance with the laws of India.</p>
// </span>
// <br>
// <span>
//     <h3 class="center-text">SCHEDULE-A</h3>
//     <p>Referral Entity desires to appoint Channel Partner for:</p>
//     <ul>
//         <ol>(1)  Contact the persons in need of financial assistance/ loan and process their application through the Mobile Application of the Referral Entity.</ol><br>
//             <ol>(2)  Help the Referral Entity in promoting their Mobile Application.</ol>
//     </ul>
// </span>
// <br>
// <span>
//     <h3 class="center-text">SCHEDULE-B</h3>
//     <p>Channel Partner shall be entitled to get the payment/ commission/ referral earning, on successful processing of financial products/ loan(s) through the Mobile Application of the Referral Entity and after disbursal of financial products/ loans by Referral Entity’s partner Financial Institution(s) like Bank(s), NBFC(s) to the end customer, in accordance with the slabs mentioned herein below:</p><br>
//     <table>
//         <tr>
//             <th>*Slab (loan amount)</th>
//             <td>0 - 50 Lacs (in Rs)</td>
//             <td>50 Lacs - 1 crore (in Rs)</td>
//             <td>1 crore and above (in Rs)</td>
//         </tr>
//         <tr>
//             <th>Percentage of Commission</th>
//             <td>1.5% of the loan amount</td>
//             <td>1.75% of the loan amount</td>
//             <td>2% of the loan amount</td>
//         </tr>
//     </table>
//     <br>
//     <p>
//         The above payments would be made within a period of 60 days since the disbursal of loan/ financial product to the end customer. This timeline is only indicative and not conclusive.<br>
//         The above payments will be made in cash or through commodities/ incentives/ cash vouchers of the equivalent value.<br>
//         *The slab(s) for the Channel partner will be calculated on the basis of total loan disbursal to the Customer(s) (concluded transactions) facilitated by the Channel Partner between the first day of the month and the last day of that particular month till 5:30 PM.
//     </p>
// </span>
// </div>

// </body>""",
//       ),
    
    );
  }
}
